import CoreKit
import UIKit
import Root

final class RootCoordinator: ConnectionCoodinator, LauncherCoordinating {
    let viewController: UIViewController = UIViewController()
//    private let luchaConnectionBuilder: LuchaConnectionBuilder
    
//    init(luchaConnectionBuilder: LuchaConnectionBuilder) {
//        self.luchaConnectionBuilder = luchaConnectionBuilder
//    }
    
    func didLaunch() {
        attach(RootBuilder().makeRoot(view: viewController, externalFeaturesBuider: self))
    }
}

extension RootCoordinator: RootExternalBuilder {
    func makeLucha(view: UIViewController) -> Coordinating {
        let bla = ViewableCoordinator.empty(viewController: view)
        
        bla.viewController.view.backgroundColor = .blue
        
        return bla
    }
}
