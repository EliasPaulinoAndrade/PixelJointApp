import UIKit

enum ModalRouterLog: Loggable {
    case enqueuedController(_ controller: UIViewController, _ parentController: UIViewController)
    case dequeuedController(_ controller: UIViewController, _ parentController: UIViewController)
    case userDismissedController(_ controller: UIViewController)
    case dismissHappendWithoutDelegate(_ controller: UIViewController, _ coordinator: ViewableCoordinating)
    
    var logDescription: String {
        switch self {
        case let .dequeuedController(dequeuedController, parentController):
            return "\(dequeuedController) was dequeued to be presented at \(parentController)"
        case let .userDismissedController(dismissedController):
            return "User manually dismissed \(dismissedController)"
        case let .dismissHappendWithoutDelegate(dismissedController, coordinator):
            // swiftlint:disable:next line_length
            return "User have dismissed the \(dismissedController) that is associeted with \(coordinator), but no delegate is set. Its recommeded to set the delegate and deattach the coordinator when the dismiss happen."
        case let .enqueuedController(enqueuedController, parentController):
            // swiftlint:disable:next line_length
            return "Tried present \(enqueuedController) controller at \(parentController) when its already presenting other controller. \(enqueuedController) was enqueued and will be presented when the current controller be dismissed"
        }
    }
}
