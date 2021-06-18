import UIKit
import SwiftUI
import CoreKit

protocol OnImageFullSizeBuildable {
    func makeOnImageFullSize(image: String, listener: OnImageFullSizeListener) -> ViewableCoordinating
}

final class OnImageFullSizeBuilder: OnImageFullSizeBuildable {
    private let externalDepedency: DetailingArtDepedencing
    
    init(externalDepedency: DetailingArtDepedencing) {
        self.externalDepedency = externalDepedency
    }
    
    func makeOnImageFullSize(image: String, listener: OnImageFullSizeListener) -> ViewableCoordinating {
        let viewStateHolder = OnImageFullSizeViewStateHolder()
        let view = OnImageFullSizeView(
            stateHolder: viewStateHolder,
            imageProvider: externalDepedency.fileProvider
        )
        let viewHosting = UIHostingController(rootView: view)
        let interactor = OnImageFullSizeInteractor(image: image, presenter: viewStateHolder)
        let coordinator = ViewableCoordinator(
            viewController: viewHosting,
            interactor: interactor
        )
        viewStateHolder.interactor = interactor
        interactor.listener = listener
        return coordinator
    }
}
