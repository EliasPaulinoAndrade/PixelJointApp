import Foundation
import UIKit

protocol MuchaPresenting: AnyObject {
    // Add methods that interactor should call
    
    func presentFighter(_ fighter: Fighter)
    func presentPlace(_ place: Place)
    func presentBannerError()
    func presentFighterError()
}

final class MuchaPresenter {
    private let view: MuchaViewable
    init(view: MuchaViewable) {
        self.view = view
    }
}

extension MuchaPresenter: MuchaPresenting {
    // MuchaPresenting methods
    
    func presentFighter(_ fighter: Fighter) {
        switch fighter {
        case .buenaGirl:
            view.showTitle("Buena Girl")
            view.showImage(LuchaAsset.buenaGirl.image)
        case .rikochet:
            view.showTitle("Rikochet")
            view.showImage(LuchaAsset.rikochet.image)
        }
    }
    
    func presentPlace(_ place: Place) {
        switch place {
        case .academy:
            view.showTitle("Hairy Knuckles Wrestling Academy")
            view.showImage(LuchaAsset.academy.image)
        case .netherNetherLand:
            view.showTitle("Nether Nether Land")
            view.showImage(LuchaAsset.netherNetherLand.image)
        case .valleySavage:
            view.showTitle("Valley of Savage Backpacks")
            view.showImage(LuchaAsset.valleySavage.image)
        }
    }
    
    func presentBannerError() {
        view.showError("This Place Cannot Be Showed")
    }
    
    func presentFighterError() {
        view.showError("You cant Zoom in fighters")
    }
}
