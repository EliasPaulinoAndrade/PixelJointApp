import UIKit
import SwiftUI

public final class TabViewController<Style: TabViewStyle>: UIHostingController<TabRouterView<Style>> {
    private let style: Style
    private let tabsStateHolder = TabRouterViewStateHolder()
    private let tabView: TabRouterView<Style>
    var onUserChangeTab: ((String, String) -> Void)? {
        didSet {
            tabsStateHolder.onUserChangeTab = onUserChangeTab
        }
    }
    
    public init(style: Style) {
        self.style = style
        self.tabView = TabRouterView(
            tabStyle: style,
            viewStateHolder: tabsStateHolder
        )
        super.init(rootView: tabView)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        nil
    }
    
    func changeToSection(with identifier: String) {
        let index = tabsStateHolder.tabs.firstIndex {
            $0.id == identifier
        }
        guard let safeIndex = index else {
            return
        }
        tabsStateHolder.currentSetTabIdentifier = tabsStateHolder.tabs[safeIndex].id
    }
    
    func add(viewController: UIViewController, identifier: String) {
        let tabChild = TabChild(
            id: identifier,
            view: TabChildViewController(viewController: viewController)
        )
        tabsStateHolder.tabs.append(tabChild)
    }
    
    func remove(viewController: UIViewController) {
        tabsStateHolder.tabs.removeAll { tabChild in
            tabChild.view.viewController === viewController
        }
    }
}
