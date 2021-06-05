import Foundation
import CoreKit
import PuccaInterface

final class LogicalInteractor: Interacting {
    weak var coordinator: LogicalCoordinating?
    func didStart() {
        // Add Logic to execute when the scene starts
//        if Bool.random() {
//            coordinator?.openMucha()
//        } else {
        coordinator?.openPucca(listener: self)
//        }
    }
}

extension LogicalInteractor: BugigangaListener {
    func userDidFinish() {
        coordinator?.closeOpenedScene()
        coordinator?.openMucha()
    }
}

extension LogicalInteractor: PuccaListener {
    func userClosed() {
        coordinator?.closeOpenedScene()
        coordinator?.openMucha()
    }
}
