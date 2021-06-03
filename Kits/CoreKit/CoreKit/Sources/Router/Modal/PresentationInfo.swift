import UIKit

struct PresentationInfo {
    let controller: UIViewController
    let coordinator: ViewableCoordinating?
    let animated: Bool
    let completion: (() -> Void)?
    let presentationStyle: UIModalPresentationStyle
}
