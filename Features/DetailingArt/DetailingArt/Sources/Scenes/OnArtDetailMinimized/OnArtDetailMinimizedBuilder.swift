import UIKit
import CoreKit
import SwiftUI
import Combine

protocol OnArtDetailMinimizedBuildable {
    func makeOnArtDetailMinimized(
        listener: OnArtDetailMinimizedListener,
        artDetailPublisher: ArtDetailInfoPublisher) -> ViewableCoordinating
}

final class OnArtDetailMinimizedBuilder: OnArtDetailMinimizedBuildable {
    private let externalDepedency: DetailingArtDepedencing
    
    init(externalDepedency: DetailingArtDepedencing) {
        self.externalDepedency = externalDepedency
    }
    
    func makeOnArtDetailMinimized(
        listener: OnArtDetailMinimizedListener,
        artDetailPublisher: ArtDetailInfoPublisher
    ) -> ViewableCoordinating {
        let viewStateHolder = OnArtDetailMinimizedViewStateHolder()
        let view = OnArtDetailMinimizedView(
            stateHolder: viewStateHolder,
            imageProvider: externalDepedency.fileProvider
        )
        let viewHosting = UIHostingController(rootView: view)
        let presenter = OnArtDetailMinimizedPresenter(view: viewStateHolder)
        let interactor = OnArtDetailMinimizedInteractor(
            presenter: presenter,
            artDetailPublisher: artDetailPublisher
        )
        let coordinator = ViewableCoordinator(
            viewController: viewHosting,
            interactor: interactor
        )
        viewStateHolder.interactor = interactor
        interactor.listener = listener
        return coordinator
    }
}
