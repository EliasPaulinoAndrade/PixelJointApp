import UIKit

open class ConnectionCoodinator: Coordinating {
    public var coordinators: [Coordinating] = []
    
    public init() { }
    
    public func attach(_ composable: Coordinating) {
        coordinators.append(composable)
        
        guard let childInteractor = composable as? InteractableCoordinating else { return }
        childInteractor.interactor.didStart()
    }
}

open class ViewableConnectionCoodinator: ViewableCoordinating {
    public let viewController: UIViewController
    public var coordinators: [Coordinating] = []
    
    public init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    public func attach(_ composable: Coordinating) {
        coordinators.append(composable)
        
        guard let childInteractor = composable as? InteractableCoordinating else { return }
        childInteractor.interactor.didStart()
    }
}

public protocol LauncherCoordinating: ViewableCoordinating {
    func didLaunch()
}

public extension LauncherCoordinating {
    func launch(window: UIWindow?) {
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        didLaunch()
    }
    
    func didLaunch() { }
}
