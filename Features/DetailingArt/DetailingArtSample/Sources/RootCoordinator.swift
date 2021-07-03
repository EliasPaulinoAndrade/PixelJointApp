import CoreKit
import UIKit
import Combine

final class RootCoordinator: ConnectionCoodinator, LauncherCoordinating {
    private let stackViewController = StackViewController()
    private let artPublisher = PassthroughSubject<URL, Never>()
    private lazy var stackRouter = StackRouter(stackViewController: stackViewController)
    private lazy var root = DetailingArtProxyBuilder().makeDetailingArt(
        view: stackViewController,
        openDetailPublisher: artPublisher.eraseToAnyPublisher(),
        stackRouter: stackRouter
    )
    lazy var viewController: UIViewController = stackViewController
    
    func didLaunch() {
        attach(root)
        
        if let sampleURL = URL(string: "/pixelart/140557.htm") {
            artPublisher.send(sampleURL)
        }
    }
}
