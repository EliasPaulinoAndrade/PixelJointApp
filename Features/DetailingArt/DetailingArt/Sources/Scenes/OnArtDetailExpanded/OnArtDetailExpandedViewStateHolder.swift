import Foundation

protocol OnArtDetailExpandedViewable: AnyObject {
    var isLoading: Bool { get set }
    var isShowingError: Bool { get set }
    var isShowingFooterError: Bool { get set }
    var isShowingFooterLoading: Bool { get set }
    var isFullSizeButtonOnHeader: Bool { get set }
    
    func showComments(_ comments: [Viewable.Comment])
    func showArtDetail(_ artDetail: Viewable.ArtDetail)
    func showNoMoreContent(text: String)
}

final class OnArtDetailExpandedViewStateHolder: ObservableObject {
    weak var interactor: OnArtDetailExpandedInteracting?
    
    @Published var artDetail: Viewable.ArtDetail?
    @Published var isLoading = false
    @Published var isShowingError = false
    @Published var isShowingFooterError = false
    @Published var isShowingFooterLoading = false
    @Published var isFullSizeButtonOnHeader = false
    @Published var comments: [Viewable.Comment] = []
    @Published var hasNoMorePagesTitle = ""
    @Published var hasNoMorePages = false
}

extension OnArtDetailExpandedViewStateHolder: OnArtDetailExpandedViewable {
    func showArtDetail(_ artDetail: Viewable.ArtDetail) {
        self.artDetail = artDetail
    }
    
    func showComments(_ comments: [Viewable.Comment]) {
        self.comments = comments
    }
    
    func showNoMoreContent(text: String) {
        hasNoMorePagesTitle = text
        hasNoMorePages = true
    }
}
