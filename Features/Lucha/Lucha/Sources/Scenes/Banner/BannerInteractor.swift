import Foundation
import CoreKit

protocol BannerInteracting: AnyObject {
    // Add methods that view should call
}

protocol BannerListener: AnyObject {
    func cannotShowThisPlace()
}

final class BannerInteractor: Interacting {
    private let presenter: BannerPresenting
    weak var coordinator: BannerCoordinating?
    weak var listener: BannerListener?
    
    private let place: Place
    
    init(presenter: BannerPresenting, place: Place) {
        self.presenter = presenter
        self.place = place
    }
    
    func didStart() {
        guard place != .academy else {
            listener?.cannotShowThisPlace()
            return
        }
        presenter.presentPlace(place)
    }
}

extension BannerInteractor: BannerInteracting {
    // BannerInteracting methods
}
