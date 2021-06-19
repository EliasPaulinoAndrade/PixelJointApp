import Foundation
import UIToolKit

protocol OnArtsListPresenting: AnyObject {
    func presentArts(_ arts: [PixelArt], tips: [PixelArtTip])
    func presentFooterLoading()
    func presentLoading()
    func presentFooterError()
    func hideFooterLoading()
    func hideLoading()
    func hideFooterError()
    func presentError()
    func hideError()
    func presentNoMoreAlerts()
}

final class OnArtsListPresenter {
    private let view: OnArtsListViewable
    init(view: OnArtsListViewable) {
        self.view = view
    }
}

extension OnArtsListPresenter: OnArtsListPresenting {
    func presentNoMoreAlerts() {
        view.hasNoMorePages = true
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
    
    func presentFooterError() {
        view.isFooterShowingError = true
    }
    
    func hideFooterError() {
        view.isFooterShowingError = false
    }
    
    func hideFooterLoading() {
        view.isFooterLoading = false
    }
    
    func presentFooterLoading() {
        view.isFooterLoading = true
    }
    
    func presentArts(_ arts: [PixelArt], tips: [PixelArtTip]) {
        let artsImagesUrls = zip(arts, tips).map { pixelArt, tip in
            OnArtsListView.ViewableArt(
                id: pixelArt.identifier,
                resource: AsyncImageResource(
                    baseURL: PixelJointConstants.baseURL,
                    path: pixelArt.image
                ),
                title: tip.title
            )
        }
        
        view.displayImages(artsImagesUrls)
    }
}
