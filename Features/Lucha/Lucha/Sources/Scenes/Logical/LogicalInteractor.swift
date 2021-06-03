import Foundation
import CoreKit

final class LogicalInteractor: Interacting {
    weak var coordinator: LogicalCoordinating?
    func didStart() {
        // Add Logic to execute when the scene starts
//        if Bool.random() {
//            coordinator?.openMucha()
//        } else {
            coordinator?.openBugiganga(listener: self)
//        }
    }
}

extension LogicalInteractor: BugigangaListener {
    func userDidFinish() {
        coordinator?.closeOpenedScene()
        coordinator?.openMucha()
    }
}
