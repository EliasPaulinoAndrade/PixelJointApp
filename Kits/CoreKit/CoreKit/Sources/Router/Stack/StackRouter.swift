import UIKit

public final class StackRouter: StackRouting {
    private let stackViewController: StackViewController
    
    public init(stackViewController: StackViewController) {
        self.stackViewController = stackViewController
    }
    
    public func add(viewController: UIViewController, height: CGFloat?, priority: UILayoutPriority?) {
        stackViewController.addComponent(viewController, height: height, priority: priority)
    }
    
    public func add(coordinator: ViewableCoordinating, height: CGFloat?, priority: UILayoutPriority?) {
        stackViewController.addComponent(coordinator.viewController, height: height, priority: priority)
    }
    
    public func remove(coordinator: ViewableCoordinating) {
        stackViewController.removeComponent(viewController: coordinator.viewController)
    }
}
