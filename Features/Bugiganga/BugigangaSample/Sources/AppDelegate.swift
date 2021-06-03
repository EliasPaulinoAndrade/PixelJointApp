import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let bugigangaConnectionBuilder = BugigangaConnectionBuilder()
    private lazy var rootCoordinator = RootCoordinator(bugigangaConnectionBuilder: bugigangaConnectionBuilder)
    
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        rootCoordinator.launch(window: window)
        return true
    }
}

