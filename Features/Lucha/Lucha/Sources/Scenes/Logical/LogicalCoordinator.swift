import CoreKit
import UIKit

protocol LogicalCoordinating: AnyObject {
    // Add methods that interactor should call to open new scenes
    func openMucha()
    func openBugiganga(listener: BugigangaListener)
    
    func closeOpenedScene()
}

final class LogicalCoordinator: Coordinator {
    private let muchaBuilder: MuchaBuildable
    private let bugigangaBuilder: BugigangaBuildable
    private let router: ModalRouting
    init(
        muchaBuilder: MuchaBuildable,
        bugigangaBuilder: BugigangaBuildable,
        router: ModalRouting,
        viewController: UIViewController,
        interactor: Interacting
    ) {
        self.muchaBuilder = muchaBuilder
        self.bugigangaBuilder = bugigangaBuilder
        self.router = router
        super.init(interactor: interactor)
    }
}

extension LogicalCoordinator: LogicalCoordinating {
    // LogicalCoordinating methods
    func openMucha() {
        let muchaScene = muchaBuilder.makeMucha()
        attach(muchaScene)
        router.present(muchaScene, animated: false, presentationStyle: .fullScreen, completion: nil)
    }
    
    func openBugiganga(listener: BugigangaListener) {
        let bugigangaScene = bugigangaBuilder.makeBugiganga(listener: listener)
        
        attach(bugigangaScene)
        router.present(bugigangaScene, animated: false, presentationStyle: .fullScreen, completion: nil)
    }
    
    func closeOpenedScene() {
        deattachLast()
        router.dismiss(animated: false, completion: nil)
    }
}
