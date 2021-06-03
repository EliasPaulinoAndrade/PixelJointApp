import Foundation
import CoreKit

final class HasStartedInteractor: Interacting {
    weak var coordinator: HasStartedCoordinating?
    func didStart() {
        coordinator?.openLucha()
    }
}
