import Foundation

protocol BannerPresenting: AnyObject {
    // Add methods that interactor should call
    func presentPlace(_ place: Place)
}

final class BannerPresenter {
    private let view: BannerViewable
    init(view: BannerViewable) {
        self.view = view
    }
}

extension BannerPresenter: BannerPresenting {
    // BannerPresenting methods
    
    func presentPlace(_ place: Place) {
        switch place {
        case .netherNetherLand:
            view.showImage(LuchaAsset.netherNetherLand.image)
        case .valleySavage:
            view.showImage(LuchaAsset.valleySavage.image)
        default:
            break
        }
    }
}
