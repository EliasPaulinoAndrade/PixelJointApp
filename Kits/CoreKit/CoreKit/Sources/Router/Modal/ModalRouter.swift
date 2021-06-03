import UIKit

public protocol ModalRouterDelegate: AnyObject {
    func userDidPopViewControllers(of coordinators: [ViewableCoordinating])
}

public class ModalRouter: NSObject, ModalRouting {
    private typealias Log = ModalRouterLog
    
    private let viewController: UIViewController
    private var presentationQueue: [PresentationInfo] = []
    private var presentedCoordinators: [UIViewController: ViewableCoordinating] = [:]
    private let logger: Logging
    
    public weak var delegate: ModalRouterDelegate?
    
    public init(viewController: UIViewController, logger: Logging) {
        self.viewController = viewController
        self.logger = logger
    }
    
    public func present(_ coordinating: ViewableCoordinating,
                        animated: Bool = true,
                        presentationStyle: UIModalPresentationStyle,
                        completion: (() -> Void)? = nil) {
        guard viewController.presentedViewController == nil else {
            let presentationInfo = PresentationInfo(
                controller: coordinating.viewController,
                coordinator: coordinating,
                animated: animated,
                completion: completion,
                presentationStyle: presentationStyle
            )
            logger.log(
                Log.enqueuedController(coordinating.viewController, viewController),
                UILog.message
            )
            return presentationQueue.append(presentationInfo)
        }
        presentedCoordinators[coordinating.viewController] = coordinating
        coordinating.viewController.modalPresentationStyle = presentationStyle
        coordinating.viewController.presentationController?.delegate = self
        viewController.present(coordinating.viewController, animated: animated, completion: completion)
    }
    
    public func present(_ viewControllerToPresent: UIViewController,
                        animated: Bool = true,
                        presentationStyle: UIModalPresentationStyle,
                        completion: (() -> Void)? = nil) {
        guard viewController.presentedViewController == nil else {
            let presentationInfo = PresentationInfo(
                controller: viewControllerToPresent,
                coordinator: nil,
                animated: animated,
                completion: completion,
                presentationStyle: presentationStyle
            )
            
            logger.log(
                Log.enqueuedController(viewControllerToPresent, viewController),
                UILog.message
            )
            return presentationQueue.append(presentationInfo)
        }
        viewController.modalPresentationStyle = presentationStyle
        if !(viewControllerToPresent is UIAlertController) {
            viewControllerToPresent.presentationController?.delegate = self
        }
        viewController.present(viewControllerToPresent, animated: animated, completion: completion)
    }
    
    public func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let presentedViewController = viewController.presentedViewController else {
            return
        }
        
        presentedCoordinators[presentedViewController] = nil
        presentedViewController.dismiss(animated: animated) { [weak self] in
            completion?()
            
            if self?.viewController.presentedViewController == nil {
                self?.presentQueuedController()
            }
        }
    }
}

// MARK: - Private Methods
private extension ModalRouter {
    func present(_ info: PresentationInfo) {
        presentedCoordinators[info.controller] = info.coordinator
        info.controller.modalPresentationStyle = info.presentationStyle
        info.controller.presentationController?.delegate = self
        viewController.present(info.controller, animated: info.animated, completion: info.completion)
    }
    
    func presentQueuedController() {
        guard let nextPresentationInfo = presentationQueue.first else {
            return
        }
        
        presentationQueue.removeFirst()
        logger.log(
            Log.dequeuedController(nextPresentationInfo.controller, viewController),
            UILog.message
        )
        present(nextPresentationInfo)
    }
    
    func userManuallyDismissed(controller dismissedController: UIViewController) {
        logger.log(Log.userDismissedController(dismissedController), UILog.message)
        
        if let coordinatorToBeDeattached = presentedCoordinators[dismissedController] {
            presentedCoordinators[dismissedController] = nil
            if let delegate = self.delegate {
                delegate.userDidPopViewControllers(of: [coordinatorToBeDeattached])
            } else {
                logger.log(Log.dismissHappendWithoutDelegate(
                    dismissedController,
                    coordinatorToBeDeattached
                ), UILog.warning)
            }
        }
        
        if viewController.presentedViewController == nil {
            presentQueuedController()
        }
    }
}

// MARK: - Presentation Delegate
extension ModalRouter: UIAdaptivePresentationControllerDelegate {
    public func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        let presentedController = presentationController.presentedViewController
        userManuallyDismissed(controller: presentedController)
    }
}
