import SwiftUI

final class TabRouterViewStateHolder: ObservableObject {
    @Published var tabs: [TabChild] = []
    @Published var currentTabIdentifier: String = ""
    var currentSetTabIdentifier: String = "" {
        didSet {
            currentTabIdentifier = currentSetTabIdentifier
        }
    }
    var onUserChangeTab: ((_ origin: String, _ target: String) -> Void)?
}

public struct TabRouterView<Style: TabViewStyle>: View {
    let tabStyle: Style
    @ObservedObject var viewStateHolder: TabRouterViewStateHolder
    
    public var body: some View {
        TabView(selection: $viewStateHolder.currentTabIdentifier) {
            ForEach(viewStateHolder.tabs) { tab in
                tab.view.tag(tab.id)
            }
        }.tabViewStyle(tabStyle)
         .onChange(of: viewStateHolder.currentTabIdentifier) { identifier in
            if identifier != viewStateHolder.currentSetTabIdentifier {
                viewStateHolder.onUserChangeTab?(viewStateHolder.currentSetTabIdentifier, identifier)
                viewStateHolder.currentSetTabIdentifier = identifier
            }
         }
    }
}
