import UIKit
import SwiftUI
import CoreKit
import UIToolKit

protocol OnArtsListBuildable {
    func makeOnArtsList(listener: OnArtsListListener) -> ViewableCoordinating
}

final class OnArtsListBuilder: OnArtsListBuildable {
    
    private let externalDepedency: ListingArtsDepedencing
    
    init(externalDepedency: ListingArtsDepedencing) {
        self.externalDepedency = externalDepedency
    }
    
    func makeOnArtsList(listener: OnArtsListListener) -> ViewableCoordinating {
        let logger = ConsoleLogger()
        let viewStateHolder = OnArtsListViewStateHolder()
        let view = OnArtsListView(
            stateHolder: viewStateHolder,
            imageProvider: externalDepedency.fileProvider
        )
        let viewHosting = UIHostingController(rootView: view)
        let navigationController = UINavigationController(rootViewController: viewHosting)
        let presenter = OnArtsListPresenter(view: viewStateHolder)
        let service = OnArtsListService(provider: externalDepedency.htmlProvider(type: PixelArtGallery.self))
        let interactor = OnArtsListInteractor(presenter: presenter, service: service, logger: logger)
        let coordinator = OnArtsListCoordinator(
            viewController: navigationController,
            interactor: interactor
        )
        viewStateHolder.interactor = interactor
        interactor.coordinator = coordinator
        interactor.listener = listener
        viewHosting.title = ListingArtsStrings.OnArtsList.listingArts
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIToolKitAsset.text.color
        ]
        navigationController.navigationBar.titleTextAttributes = [
            .foregroundColor: UIToolKitAsset.text.color
        ]

        viewHosting.view.backgroundColor = UIToolKitAsset.darkBackground.color
        
        return coordinator
    }
}
