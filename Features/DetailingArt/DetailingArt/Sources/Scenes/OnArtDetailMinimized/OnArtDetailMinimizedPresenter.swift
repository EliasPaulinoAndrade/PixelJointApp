import Foundation
import UIToolKit

protocol OnArtDetailMinimizedPresenting: AnyObject {
    func presentArt(_ artDetail: PixelArtDetail)
    func presentLoading()
    func hideLoading()
    func presentError()
    func hideError()
}

final class OnArtDetailMinimizedPresenter {
    private let view: OnArtDetailMinimizedViewable
    init(view: OnArtDetailMinimizedViewable) {
        self.view = view
    }
}

extension OnArtDetailMinimizedPresenter: OnArtDetailMinimizedPresenting {
    func presentArt(_ artDetail: PixelArtDetail) {
        let viewableArtDetail = ViewableMinimizedArtDetail(
            title: artDetail.title,
            author: artDetail.authorName,
            imageResource: AsyncImageResource(
                baseURL: PixelJointConstants.baseURL,
                path: artDetail.smallImage ?? artDetail.detailImage
            )
        )
        view.displayArt(viewableArtDetail)
    }
    
    func presentError() {
        view.isShowingError = true
    }
    
    func hideError() {
        view.isShowingError = false
    }
    
    func presentLoading() {
        view.isLoading = true
    }
    
    func hideLoading() {
        view.isLoading = false
    }
}
