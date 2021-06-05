import UIKit
import SwiftUI
import CoreKit

protocol InitialBuildable {
    func makeInitial(listener: InitialListener) -> ViewableCoordinating
}

final class InitialBuilder: InitialBuildable {
    func makeInitial(listener: InitialListener) -> ViewableCoordinating {
        let viewController = InitialViewController()
        let view = InitialView(controller: viewController)
        let viewHosting = UIHostingController(rootView: view)
        let interactor = InitialInteractor(presenter: viewController)
        let coordinator = InitialCoordinator(
            viewController: viewHosting,
            interactor: interactor
        )
        viewController.interactor = interactor
        interactor.coordinator = coordinator
        interactor.listener = listener
        return coordinator
    }
}
