import UIKit
import CoreKit
import SwiftUI
import Combine

protocol OnArtDetailExpandedBuildable {
    func makeOnArtDetail(artDetailPublisher: ArtDetailInfoPublisher,
                         listener: OnArtDetailExpandedListener) -> ViewableCoordinating
}

final class OnArtDetailExpandedBuilder: OnArtDetailExpandedBuildable {
    private let externalDepedency: DetailingArtDepedencing
    
    init(externalDepedency: DetailingArtDepedencing) {
        self.externalDepedency = externalDepedency
    }
    
    func makeOnArtDetail(artDetailPublisher: ArtDetailInfoPublisher,
                         listener: OnArtDetailExpandedListener) -> ViewableCoordinating {
        let viewStateHolder = OnArtDetailExpandedViewStateHolder()
        let view = OnArtDetailExpandedView(
            stateHolder: viewStateHolder,
            imageProvider: externalDepedency.fileProvider
        )
        let viewHosting = UIHostingController(rootView: view)
        let presenter = OnArtDetailExpandedPresenter(view: viewStateHolder)
        let logger = ConsoleLogger()
        let service = OnArtDetailExpandedService(
            provider: externalDepedency.htmlProvider(type: CommentPage.self)
        )
        let interactor = OnArtDetailExpandedInteractor(
            presenter: presenter,
            service: service,
            artDetailPublisher: artDetailPublisher,
            logger: logger,
            depedencies: externalDepedency
        )
        let coordinator = OnArtDetailExpandedCoordinator(
            fullSizeImageBuilder: OnImageFullSizeBuilder(externalDepedency: externalDepedency),
            modalRouter: ModalRouter(viewController: viewHosting, logger: logger),
            viewController: viewHosting,
            interactor: interactor
        )
        viewStateHolder.interactor = interactor
        interactor.coordinator = coordinator
        interactor.listener = listener
        return coordinator
    }
}
