import UIKit
import SwiftUI
import CoreKit

protocol InspectorBuildable {
    func makeInspector(listener: InspectorListener) -> ViewableCoordinating
}

final class InspectorBuilder: InspectorBuildable {
    func makeInspector(listener: InspectorListener) -> ViewableCoordinating {
        let viewController = InspectorViewController()
        let view = InspectorView(controller: viewController)
        let viewHosting = UIHostingController(rootView: view)
        let interactor = InspectorInteractor(presenter: viewController)
        let coordinator = InspectorCoordinator(
            viewController: viewHosting,
            interactor: interactor
        )
        viewController.interactor = interactor
        interactor.coordinator = coordinator
        interactor.listener = listener
        
        return coordinator
    }
}
