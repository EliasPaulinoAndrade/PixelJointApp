import UIKit
import CoreKit

protocol LogicalBuildable {
    func makeLogical() -> Coordinating
}

final class LogicalBuilder: LogicalBuildable {
    private let view: UIViewController
    private let externalFeaturesBuider: LuchaExternalBuildable
    
    init(view: UIViewController, externalFeaturesBuider: LuchaExternalBuildable) {
        self.view = view
        self.externalFeaturesBuider = externalFeaturesBuider
    }
    func makeLogical() -> Coordinating {
        let interactor = LogicalInteractor()
        let coordinator = LogicalCoordinator(
            muchaBuilder: MuchaBuilder(),
            bugigangaBuilder: externalFeaturesBuider,
            router: ModalRouter(viewController: view, logger: ConsoleLogger()),
            viewController: view,
            interactor: interactor
        )
        interactor.coordinator = coordinator
        return coordinator
    }
}
