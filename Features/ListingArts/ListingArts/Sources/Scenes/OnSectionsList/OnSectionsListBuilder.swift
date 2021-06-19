import UIKit
import CoreKit
import SwiftUI
import ListingArtsInterface
import UIToolKit

protocol OnSectionsListBuildable {
    func makeOnSectionsList(listener: OnSectionsListListener) -> ViewableCoordinating
}

final class OnSectionsListBuilder: OnSectionsListBuildable {
    private typealias Strings = ListingArtsStrings.OnSectionsList
    private let externalDepedency: ListingArtsDepedencing
    
    init(externalDepedency: ListingArtsDepedencing) {
        self.externalDepedency = externalDepedency
    }
    
    func makeOnSectionsList(listener: OnSectionsListListener) -> ViewableCoordinating {
        let viewStateHolder = OnSectionsListViewStateHolder()
        let view = OnSectionsListView(stateHolder: viewStateHolder)
        let viewHosting = UIHostingController(rootView: view)
        
        let stackViewController = StackViewController()
        let stackRouter = StackRouter(stackViewController: stackViewController)
        
        let tabViewController = TabViewController(style: PageTabViewStyle(indexDisplayMode: .never))
        let tabRouter = TabRouter(tabViewController: tabViewController)
        
        let navigationController = UINavigationController(rootViewController: stackViewController)
        
        let presenter = OnSectionsListPresenter(view: viewStateHolder)
        let interactor = OnSectionsListInteractor(presenter: presenter)
                
        let coordinator = OnSectionsListCoordinator(
            viewController: navigationController,
            interactor: interactor,
            tabRouter: tabRouter,
            listingArtsBuilder: OnArtsListBuilder(externalDepedency: externalDepedency)
        )
        
        viewStateHolder.interactor = interactor
        interactor.coordinator = coordinator
        interactor.listener = listener
        tabRouter.delegate = interactor
        
        stackRouter.add(viewController: viewHosting, height: nil, priority: .required)
        stackRouter.add(viewController: tabViewController, height: nil, priority: nil)
        
        navigationController.navigationBar.prefersLargeTitles = true
        stackViewController.title = Strings.pixelJoint
        viewHosting.view.backgroundColor = UIToolKitAsset.darkBackground.color
        tabViewController.view.backgroundColor = UIToolKitAsset.background.color
        navigationController.view.backgroundColor = UIToolKitAsset.darkBackground.color
        navigationController.navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIToolKitAsset.text.color
        ]
        
        return coordinator
    }
}
