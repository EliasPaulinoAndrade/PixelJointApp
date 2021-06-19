import UIKit

public protocol TabRouting {
    func changeToTab(with identifier: String)
    func add(coordinator: ViewableCoordinating, identifier: String)
    func add(viewController: UIViewController, identifier: String)
    func remove(coordinator: ViewableCoordinating)
    func remove(viewController: UIViewController)
}

public protocol StackRouting {
    func add(viewController: UIViewController, height: CGFloat?, priority: UILayoutPriority?)
    func add(coordinator: ViewableCoordinating, height: CGFloat?, priority: UILayoutPriority?)
    func remove(coordinator: ViewableCoordinating)
}

public protocol HierarchyRouting {
    func push(_ coordinating: ViewableCoordinator)
    func pop()
    func whenFinishPop(_ completion: @escaping () -> Void)
    func whenFinishPush(_ completion: @escaping () -> Void)
}

public protocol ModalRouting {
    func present(_ coordinating: ViewableCoordinating,
                 animated: Bool,
                 presentationStyle: UIModalPresentationStyle,
                 completion: (() -> Void)?)
    func present(_ viewControllerToPresent: UIViewController,
                 animated: Bool,
                 presentationStyle: UIModalPresentationStyle,
                 completion: (() -> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

public extension ModalRouting {
    func present(_ coordinating: ViewableCoordinating) {
        present(coordinating, animated: true, presentationStyle: .automatic, completion: nil)
    }
    
    func present(_ viewControllerToPresent: UIViewController) {
        present(viewControllerToPresent, animated: true, presentationStyle: .automatic, completion: nil)
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
