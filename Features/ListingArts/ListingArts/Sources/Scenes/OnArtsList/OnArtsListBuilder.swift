import UIKit
import SwiftUI
import CoreKit
import UIToolKit

protocol OnArtsListBuildable {
    func makeOnArtsList(section: ArtListSection,
                        listener: OnArtsListListener) -> SwiftUIViewableCoordinator<OnArtsListView>
}

final class OnArtsListBuilder: OnArtsListBuildable {
    
    private let externalDepedency: ListingArtsDepedencing
    private let isVertical: Bool
    
    init(externalDepedency: ListingArtsDepedencing, isVertical: Bool) {
        self.externalDepedency = externalDepedency
        self.isVertical = isVertical
    }
    
    func makeOnArtsList(section: ArtListSection,
                        listener: OnArtsListListener) -> SwiftUIViewableCoordinator<OnArtsListView> {
        let logger = ConsoleLogger()
        let viewStateHolder = OnArtsListViewStateHolder()
        let view = OnArtsListView(
            stateHolder: viewStateHolder,
            imageProvider: externalDepedency.fileProvider,
            isVertical: isVertical
        )
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
        let coordinator = SwiftUIViewableCoordinator(
            view: view,
            interactor: interactor
        )
        viewStateHolder.interactor = interactor
        interactor.listener = listener
        
        return coordinator
    }
}
