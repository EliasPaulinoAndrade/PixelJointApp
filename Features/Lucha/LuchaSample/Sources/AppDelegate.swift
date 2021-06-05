import UIKit
import Bugiganga

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    private let luchaConnectionBuilder = LuchaConnectionBuilder()
    private lazy var rootCoordinator = RootCoordinator(luchaConnectionBuilder: luchaConnectionBuilder)
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        rootCoordinator.launch(window: window)
        
        return true
    }
}

