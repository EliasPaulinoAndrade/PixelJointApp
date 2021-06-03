import UIKit

struct PopTransitionState {
    let pushedCoordinators: [UIViewController: ViewableCoordinating]
    let coordinatorsToDeattach: [ViewableCoordinating]
    let pushedViewControllers: [UIViewController]
}
