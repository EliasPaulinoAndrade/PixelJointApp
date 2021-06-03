import CoreKit
import UIKit

protocol MuchaCoordinating: AnyObject {
    // Add methods that interactor should call to open new scenes
    
    func openBanner(place: Place, listener: BannerListener)
    func closeBanner()
    func openError(message: String)
}

final class MuchaCoordinator: ViewableCoordinator {
    private let bannerBuilder: BannerBuildable
    private let modalRouter: ModalRouting
    private let hierarchyRouter: HierarchyRouting

    init(
        bannerBuilder: BannerBuildable,
        viewController: UIViewController,
        modalRouter: ModalRouting,
        hierarchyRouter: HierarchyRouting,
        interactor: Interacting
    ) {
        self.bannerBuilder = bannerBuilder
        self.modalRouter = modalRouter
        self.hierarchyRouter = hierarchyRouter
        super.init(viewController: viewController, interactor: interactor)
    }
}

extension MuchaCoordinator: MuchaCoordinating {
    // MuchaCoordinating methods
    
    func openBanner(place: Place, listener: BannerListener) {
        let bannerScene = bannerBuilder.makeBanner(place: place, listener: listener)
        
        hierarchyRouter.push(bannerScene)
        attach(bannerScene)
    }
    
    func closeBanner() {
        hierarchyRouter.pop()
        deattachLast()
    }
    
    func openError(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        
        hierarchyRouter.whenFinishPop { [modalRouter] in
            modalRouter.present(alertController)
        }
    }
}

extension MuchaCoordinator: HierarchyRouterDelegate, ModalRouterDelegate {
    public func userDidPopViewControllers(of coordinators: [ViewableCoordinating]) {
        deattach(coordinators)
    }
}

