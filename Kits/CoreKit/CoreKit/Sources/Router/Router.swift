import UIKit

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
    func present(_ coordinating: ViewableCoordinator) {
        present(coordinating, animated: true, presentationStyle: .automatic, completion: nil)
    }
    
    func present(_ viewControllerToPresent: UIViewController) {
        present(viewControllerToPresent, animated: true, presentationStyle: .automatic, completion: nil)
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
