import UIKit

struct HierarchyState {
    private(set) var pushedViewControllers: [UIViewController] = []
    private(set) var pushedCoordinators: [UIViewController: ViewableCoordinating] = [:]
    
    mutating func addCoordinator(_ coordinating: ViewableCoordinating) {
        pushedViewControllers.append(coordinating.viewController)
        pushedCoordinators[coordinating.viewController] = coordinating
    }
    
    mutating func removeCoordinatorOf(viewController: UIViewController) {
        pushedCoordinators[viewController] = nil
        pushedViewControllers.removeAll {
            $0 == viewController
        }
    }
}
