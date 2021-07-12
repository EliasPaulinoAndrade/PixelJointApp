import UIKit
import CoreKit
import SwiftUI
import ListingArtsInterface
import UIToolKit

protocol OnSectionsListBuildable {
    func makeOnSectionsList(listener: OnSectionsListListener,
                            isVertical: Bool) -> ViewableCoordinating
}

final class OnSectionsListBuilder: OnSectionsListBuildable {
    private typealias Strings = ListingArtsStrings.OnSectionsList
    private let externalDepedency: ListingArtsDepedencing
    
    init(externalDepedency: ListingArtsDepedencing) {
        self.externalDepedency = externalDepedency
    }
    
    func makeOnSectionsList(listener: OnSectionsListListener,
                            isVertical: Bool) -> ViewableCoordinating {
        let viewStateHolder = OnSectionsListViewStateHolder()
        let view = OnSectionsListView(stateHolder: viewStateHolder)
        let viewHosting = UIHostingController(rootView: view)
        let navigationController = UINavigationController(rootViewController: viewHosting)
        let presenter = OnSectionsListPresenter(view: viewStateHolder)
        let interactor = OnSectionsListInteractor(presenter: presenter)
                
        let coordinator = OnSectionsListCoordinator(
            viewController: navigationController,
            sectionsViewCoordinatable: viewStateHolder,
            interactor: interactor,
            listingArtsBuilder: OnArtsListBuilder(
                externalDepedency: externalDepedency,
                isVertical: isVertical
            )
        )
        
        interactor.coordinator = coordinator
        interactor.listener = listener

        navigationController.navigationBar.prefersLargeTitles = true
        viewHosting.view.backgroundColor = Colors.background2.color
        navigationController.view.backgroundColor = Colors.background2.color
        navigationController.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: Colors.text2.color
        ]
        
        return coordinator
    }
}
