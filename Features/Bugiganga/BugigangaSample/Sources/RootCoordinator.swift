import CoreKit
import UIKit

final class RootCoordinator: ConnectionCoodinator, LauncherCoordinating {
    private let bugigangaConnection: BugigangaConnection
    
    var viewController: UIViewController {
        bugigangaConnection.viewController
    }
    
    init(bugigangaConnectionBuilder: BugigangaConnectionBuilder) {
        self.bugigangaConnection = bugigangaConnectionBuilder.makeBugigangaConnection()
    }
    
    func didLaunch() {
        attach(bugigangaConnection)
    }
}
