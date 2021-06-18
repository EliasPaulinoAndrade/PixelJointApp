import Foundation

protocol OnArtsListViewable: AnyObject {
    var isFooterLoading: Bool { get set }
    var isLoading: Bool { get set }
    var isFooterShowingError: Bool { get set }
    var isShowingError: Bool { get set }
    var hasNoMorePages: Bool { get set }
    
    func displayImages(_ arts: [ViewableArt])
}

final class OnArtsListViewStateHolder: ObservableObject {
    weak var interactor: OnArtsListInteracting?
    @Published var arts: [ViewableArt] = []
    @Published var isFooterLoading = false
    @Published var isLoading = false
    @Published var isFooterShowingError = false
    @Published var isShowingError = false
    @Published var hasNoMorePages = false
}


extension OnArtsListViewStateHolder: OnArtsListViewable {
    func displayImages(_ arts: [ViewableArt]) {
        self.arts = arts
    }
}
