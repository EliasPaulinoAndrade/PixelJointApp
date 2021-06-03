import UIKit

public protocol HierarchyRouterDelegate: AnyObject {
    func userDidPopViewControllers(of coordinators: [ViewableCoordinating])
}

public class HierarchyRouter: NSObject, HierarchyRouting {
    private typealias Log = HierarchyRouterLog
    private typealias AnimationCompletion = () -> Void
    private typealias ViewControllersState = (pushed: [UIViewController], popped: [UIViewController])
    
    private let logger: Logging
    private let navigationController: UINavigationController
    private var hierarchyState = HierarchyState()
    private var popAnimationState = AnimationState()
    private var pushAnimationState = AnimationState()
    
    public weak var delegate: HierarchyRouterDelegate?
    
    public init(navigationController: UINavigationController, logger: Logging) {
        self.navigationController = navigationController
        self.logger = logger
        super.init()
        setupNavigationController(navigationController)
    }
    
    public func push(_ coordinating: ViewableCoordinator) {
        hierarchyState.addCoordinator(coordinating)
        pushAnimationState.isAnimating = true
        navigationController.pushViewController(coordinating.viewController, animated: true)
    }
    
    public func pop() {
        guard let lastViewController = navigationController.viewControllers.last else {
            return
        }
        
        hierarchyState.removeCoordinatorOf(viewController: lastViewController)
        popAnimationState.isAnimating = true
        navigationController.popViewController(animated: true)
    }
    
    public func whenFinishPush(_ completion: @escaping () -> Void) {
        guard pushAnimationState.isAnimating else {
            return completion()
        }
        
        pushAnimationState.completions.append(completion)
    }
    
    public func whenFinishPop(_ completion: @escaping () -> Void) {
        guard popAnimationState.isAnimating else {
            return completion()
        }
        
        popAnimationState.completions.append(completion)
    }
}

// MARK: - Private Methods
private extension HierarchyRouter {
    func setupNavigationController(_ navigationController: UINavigationController) {
        if let currentDelegate = navigationController.delegate {
            if currentDelegate is HierarchyRouting {
                logger.log(Log.navigationHasAlreadyARouter(navigation: navigationController), UILog.critical)
            } else {
                logger.log(Log.navigationHasAlreadyDelegate(delegate: currentDelegate), UILog.critical)
            }
        }
        
        navigationController.delegate = self
    }
    
    func callPushCompletions() {
        let completions = pushAnimationState.completions
        pushAnimationState = AnimationState()
        completions.forEach { $0() }
    }
    
    func callPopCompletions() {
        let completions = popAnimationState.completions
        popAnimationState = AnimationState()
        completions.forEach { $0() }
    }
    
    func getPopTransitionState(currentState: HierarchyState,
                               topViewController: UIViewController) -> PopTransitionState {
        guard let topControllerIndex = currentState.pushedViewControllers.firstIndex(of: topViewController) else {
            return PopTransitionState(
                pushedCoordinators: [:],
                coordinatorsToDeattach: Array(currentState.pushedCoordinators.values),
                pushedViewControllers: []
            )
        }
        
        let firstPoppedIndex = topControllerIndex + 1
        
        let poppedViewControllers = currentState.pushedViewControllers[firstPoppedIndex...]
        let cleanPushedViewControllers = Array(currentState.pushedViewControllers[...topControllerIndex])
        
        let cleanPushedCoordinators = currentState.pushedCoordinators.filter { viewController, _ in
            cleanPushedViewControllers.contains(viewController)
        }
        let coordinatorsToBeDeattached = currentState.pushedCoordinators.values.filter { coordinator in
            poppedViewControllers.contains(coordinator.viewController)
        }
        
        return PopTransitionState(
            pushedCoordinators: cleanPushedCoordinators,
            coordinatorsToDeattach: coordinatorsToBeDeattached,
            pushedViewControllers: cleanPushedViewControllers
        )
    }
    
    func userManuallyPoppedTo(viewController: UIViewController) {
        let transitionState = getPopTransitionState(currentState: hierarchyState, topViewController: viewController)
        let coordinatorsToDeattach = transitionState.coordinatorsToDeattach
        
        hierarchyState = HierarchyState(
            pushedViewControllers: transitionState.pushedViewControllers,
            pushedCoordinators: transitionState.pushedCoordinators
        )
        
        logger.log(Log.userManuallyPopped(coordinatorsToDeattach), UILog.message)
        
        guard let delegate = self.delegate else {
            return logger.log(Log.popHappendWithoutDelegate(coordinatorsToDeattach), UILog.warning)
        }
        
        delegate.userDidPopViewControllers(of: coordinatorsToDeattach)
    }
}

// MARK: - Navigation Delegate
extension HierarchyRouter: UINavigationControllerDelegate {
    
    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController,
                                     animated: Bool) {
        guard let previousViewController = navigationController
                .transitionCoordinator?
                .viewController(forKey: .from) else {
            return logger.log(Log.cannotIdentifyPreviousController(viewController), UILog.critical)
        }
        
        let wasPopped = !navigationController.viewControllers.contains(previousViewController)
        let wasPopedByUser = hierarchyState.pushedViewControllers.contains(previousViewController)
        
        guard wasPopped else {
            return callPushCompletions()
        }
        
        callPopCompletions()
        
        guard wasPopedByUser else {
            return
        }
        
        userManuallyPoppedTo(viewController: viewController)
    }
}
