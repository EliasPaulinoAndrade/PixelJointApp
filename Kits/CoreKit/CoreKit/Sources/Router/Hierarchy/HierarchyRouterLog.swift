import UIKit

enum HierarchyRouterLog: Loggable {
    case userManuallyPopped(_ coordinators: [ViewableCoordinating])
    case cannotIdentifyPreviousController(_ controller: UIViewController)
    case popHappendWithoutDelegate(_ coordinators: [ViewableCoordinating])
    case navigationHasAlreadyDelegate(delegate: UINavigationControllerDelegate)
    case navigationHasAlreadyARouter(navigation: UINavigationController)
    
    var logDescription: String {
        switch self {
        case let .userManuallyPopped(coordinators):
            return "User manually popped viewControllers associeted with \(coordinators)"
        case let .cannotIdentifyPreviousController(controller):
            return "\(controller) was showed but it was not possible identify the previous viewController."
        case let .popHappendWithoutDelegate(coordinators):
            // swiftlint:disable:next line_length
            return "User have popped the controllers associeted with the \(coordinators), but no delegate is set. Its recommeded to set the delegate and deattach the coordinator when the pop happen. This operation cannot be conclued."
        case let .navigationHasAlreadyDelegate(delegate):
            // swiftlint:disable:next line_length
            return "The UINavigationController referenced by HierarchyRouter has already a delegate set(\(delegate)). It will be overwritten"
        case let .navigationHasAlreadyARouter(navigation):
            // swiftlint:disable:next line_length
            return "Looks you have already set a HierarchyRouter to the UINavigationController(\(navigation)). Each navigation controller can have only one router."
        }
    }
}
