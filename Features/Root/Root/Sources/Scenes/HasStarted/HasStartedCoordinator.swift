import CoreKit
import UIKit

protocol HasStartedCoordinating: AnyObject {
    func openLucha()
}

final class HasStartedCoordinator: Coordinator {
    private let luchaBuildable: LuchaBuildable
    private let router: OverlapRouting
    
    init(luchaBuildable: LuchaBuildable, router: OverlapRouting, interactor: Interacting) {
        self.luchaBuildable = luchaBuildable
        self.router = router
        super.init(interactor: interactor)
    }
}

extension HasStartedCoordinator: HasStartedCoordinating {
    func openLucha() {
        let viewController = UIViewController()
        let luchaScene = luchaBuildable.makeLucha(view: viewController)
        
        router.push(view: viewController.view)
        attach(luchaScene)
//        router.push(coordinating: luchaScene)
    }
}
