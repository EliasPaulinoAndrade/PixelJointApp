import UIKit
import CoreKit

protocol MuchaBuildable {
    func makeMucha() -> ViewableCoordinator
}

final class MuchaBuilder: MuchaBuildable {
    func makeMucha() -> ViewableCoordinator {
        let view = MuchaViewController()
        let navigationView = UINavigationController(rootViewController: view)
        let presenter = MuchaPresenter(view: view)
        let interactor = MuchaInteractor(presenter: presenter)
        let hierarchyRouter = HierarchyRouter(navigationController: navigationView, logger: ConsoleLogger())
        let modalRouter = ModalRouter(viewController: view, logger: ConsoleLogger())
        let coordinator = MuchaCoordinator(
            bannerBuilder: BannerBuilder(),
            viewController: navigationView,
            modalRouter: modalRouter,
            hierarchyRouter: hierarchyRouter,
            interactor: interactor
        )
        view.interactor = interactor
        interactor.coordinator = coordinator
        hierarchyRouter.delegate = coordinator
        modalRouter.delegate = coordinator
        
        return coordinator
    }
}
