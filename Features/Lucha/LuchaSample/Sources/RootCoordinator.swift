import CoreKit
import UIKit

final class RootCoordinator: ConnectionCoodinator, LauncherCoordinating {
    let viewController: UIViewController = UIViewController()
    private let luchaConnectionBuilder: LuchaConnectionBuilder
    
    init(luchaConnectionBuilder: LuchaConnectionBuilder) {
        self.luchaConnectionBuilder = luchaConnectionBuilder
    }
    
    func didLaunch() {
        attach(luchaConnectionBuilder.makeLuchaConnection(viewController: viewController))
    }
}
