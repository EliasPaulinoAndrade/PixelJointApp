import UIKit
import CoreKit

protocol BannerBuildable {
    func makeBanner(place: Place, listener: BannerListener) -> ViewableCoordinator
}

final class BannerBuilder: BannerBuildable {
    func makeBanner(place: Place, listener: BannerListener) -> ViewableCoordinator {
        let view = BannerViewController()
        let presenter = BannerPresenter(view: view)
        let interactor = BannerInteractor(presenter: presenter, place: place)
        let coordinator = BannerCoordinator(
            viewController: view,
            interactor: interactor
        )
        view.interactor = interactor
        interactor.coordinator = coordinator
        interactor.listener = listener
        return coordinator
    }
}
