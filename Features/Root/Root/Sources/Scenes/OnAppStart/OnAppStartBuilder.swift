import UIKit
import CoreKit

protocol OnAppStartBuildable {
    func makeOnAppStart() -> ViewableCoordinating
}

final class OnAppStartBuilder: OnAppStartBuildable {
    private let externalBuilder: RootExternalBuildable
    private let externalDepedency: RootExternalDepedencing
    
    init(externalBuilder: RootExternalBuildable, externalDepedency: RootExternalDepedencing) {
        self.externalBuilder = externalBuilder
        self.externalDepedency = externalDepedency
    }
    
    func makeOnAppStart() -> ViewableCoordinating {
        let view = StackViewController()
        let interactor = OnAppStartInteractor(depedencies: externalDepedency, logger: ConsoleLogger())
        let coordinator = OnAppStartCoordinator(
            listingArtsBuilder: externalBuilder,
            detailingArtBuilder: externalBuilder,
            stackRouter: StackRouter(stackViewController: view),
            viewController: view,
            interactor: interactor
        )
        interactor.coordinator = coordinator
        return coordinator
    }
}
