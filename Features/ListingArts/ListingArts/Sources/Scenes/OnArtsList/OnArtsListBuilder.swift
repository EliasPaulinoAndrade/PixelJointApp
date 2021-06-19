import UIKit
import SwiftUI
import CoreKit
import UIToolKit

protocol OnArtsListBuildable {
    func makeOnArtsList(section: ArtListSection, listener: OnArtsListListener) -> ViewableCoordinating
}

final class OnArtsListBuilder: OnArtsListBuildable {
    
    private let externalDepedency: ListingArtsDepedencing
    
    init(externalDepedency: ListingArtsDepedencing) {
        self.externalDepedency = externalDepedency
    }
    
    func makeOnArtsList(section: ArtListSection, listener: OnArtsListListener) -> ViewableCoordinating {
        let logger = ConsoleLogger()
        let viewStateHolder = OnArtsListViewStateHolder()
        let view = OnArtsListView(
            stateHolder: viewStateHolder,
            imageProvider: externalDepedency.fileProvider
        )
        let viewHosting = UIHostingController(rootView: view)
        let presenter = OnArtsListPresenter(view: viewStateHolder)
        let service = OnArtsListService(
            provider: externalDepedency.htmlProvider(type: PixelArtGallery.self),
            section: section
        )
        let interactor = OnArtsListInteractor(
            presenter: presenter,
            service: service,
            logger: logger
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
