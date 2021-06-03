import UIKit
import CoreKit

protocol HasStartedBuildable {
    func makeHasStarted() -> Coordinating
}

final class HasStartedBuilder: HasStartedBuildable {
    private let view: UIViewController
    private let externalFeaturesBuider: RootExternalBuilder
    
    init(view: UIViewController, externalFeaturesBuider: RootExternalBuilder) {
        self.view = view
        self.externalFeaturesBuider = externalFeaturesBuider
    }
    
    func makeHasStarted() -> Coordinating {
        let interactor = HasStartedInteractor()
        let overlapView = OverlapView()
        view.view = overlapView
        let coordinator = HasStartedCoordinator(
            luchaBuildable: externalFeaturesBuider,
            router: OverlapRouter(overlapView: overlapView),
            interactor: interactor
        )
        interactor.coordinator = coordinator
        return coordinator
    }
}
