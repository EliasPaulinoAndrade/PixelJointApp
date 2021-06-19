import CoreKit
import UIKit

protocol OnSectionsListCoordinating: AnyObject {
    func openArtsListing(sections: [ArtListSection], listener: OnArtsListListener)
    func goToSection(identifier: String)
}

final class OnSectionsListCoordinator: ViewableCoordinator {
    
    private let listingArtsBuilder: OnArtsListBuildable
    private let tabRouter: TabRouting

    init(viewController: UIViewController,
         interactor: Interacting,
         tabRouter: TabRouting,
         listingArtsBuilder: OnArtsListBuildable
    ) {
        self.tabRouter = tabRouter
        self.listingArtsBuilder = listingArtsBuilder
        super.init(viewController: viewController, interactor: interactor)
    }
}

extension OnSectionsListCoordinator: OnSectionsListCoordinating {
    func goToSection(identifier: String) {
        tabRouter.changeToTab(with: identifier)
    }
    
    func openArtsListing(sections: [ArtListSection], listener: OnArtsListListener) {
        sections.forEach { section in
            let artsListing = listingArtsBuilder.makeOnArtsList(section: section, listener: listener)
            
            attach(artsListing)
            tabRouter.add(coordinator: artsListing, identifier: section.identifier)
        }
    }
}
