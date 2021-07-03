import UIKit
import CoreKit
import Combine

protocol OnArtDetailBuildable {
    func makeOnArtDetail(openDetailPublisher: AnyPublisher<URL, Never>,
                         stackRouter: StackRouting) -> Coordinating
}

final class OnArtDetailBuilder: OnArtDetailBuildable {
    private let view: UIViewController
    private let externalDepedency: DetailingArtDepedencing
    
    init(view: UIViewController, externalDepedency: DetailingArtDepedencing) {
        self.view = view
        self.externalDepedency = externalDepedency
    }

    func makeOnArtDetail(openDetailPublisher: AnyPublisher<URL, Never>,
                         stackRouter: StackRouting) -> Coordinating {
        let logger = ConsoleLogger()
        let interactor = OnArtDetailInteractor(
            service: OnArtDetailService(provider: externalDepedency.htmlProvider(type: PixelArtDetail.self)),
            openDetailPublisher: openDetailPublisher,
            logger: logger
        )
        let modalRouter = ModalRouter(viewController: view, logger: logger)
        let coordinator = OnArtDetailCoordinator(
            modalRouter: modalRouter,
            stackRouter: stackRouter,
            artDetailExpandedBuilder: OnArtDetailExpandedBuilder(externalDepedency: externalDepedency),
            artDetailMinimizedBuilder: OnArtDetailMinimizedBuilder(externalDepedency: externalDepedency),
            interactor: interactor
        )
        interactor.coordinator = coordinator
        modalRouter.delegate = coordinator
        return coordinator
    }
}
