import Foundation

protocol OnArtsListViewable: AnyObject {
    var isFooterLoading: Bool { get set }
    var isLoading: Bool { get set }
    var isFooterShowingError: Bool { get set }
    var isShowingError: Bool { get set }
    var hasNoMorePages: Bool { get set }
    
    func displayImages(_ arts: [OnArtsListView.ViewableArt])
}

final class OnArtsListViewStateHolder: ObservableObject {
    weak var interactor: OnArtsListInteracting?
    
    @Published var arts: [OnArtsListView.ViewableArt] = []
    @Published var isFooterLoading = false
    @Published var isLoading = false
    @Published var isFooterShowingError = false
    @Published var isShowingError = false
    @Published var hasNoMorePages = false
}


extension OnArtsListViewStateHolder: OnArtsListViewable {
    func displayImages(_ arts: [OnArtsListView.ViewableArt]) {
        self.arts = arts
    }
}
