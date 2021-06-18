import CoreKit
import UIKit

final class RootCoordinator: ConnectionCoodinator, LauncherCoordinating {
    private let root = RootProxyBuilder().makeRoot()
    lazy var viewController: UIViewController = root.viewController
    
    func didLaunch() {
        attach(root)
    }
}
