import Foundation

protocol OnArtDetailMinimizedViewable: AnyObject {
    var isShowingError: Bool { get set }
    var isLoading: Bool { get set }
    
    func displayArt(_ artDetail: ViewableMinimizedArtDetail)
}

final class OnArtDetailMinimizedViewStateHolder: ObservableObject {
    weak var interactor: OnArtDetailMinimizedInteracting?
    
    @Published var artDetail: ViewableMinimizedArtDetail?
    @Published var isShowingError = false
    @Published var isLoading = true
}

extension OnArtDetailMinimizedViewStateHolder: OnArtDetailMinimizedViewable {
    func displayArt(_ artDetail: ViewableMinimizedArtDetail) {
        self.artDetail = artDetail
    }
}
