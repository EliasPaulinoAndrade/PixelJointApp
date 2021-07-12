import CoreKit
import UIKit

protocol OnSectionsListCoordinating: AnyObject {
    func openArtsListing(sections: [ArtListSection], listener: OnArtsListListener)
}

final class OnSectionsListCoordinator: ViewableCoordinator {
    
    private let listingArtsBuilder: OnArtsListBuildable
    private let sectionsViewCoordinatable: OnSectionsListViewCoordinatable

    init(viewController: UIViewController,
         sectionsViewCoordinatable: OnSectionsListViewCoordinatable,
         interactor: Interacting,
         listingArtsBuilder: OnArtsListBuildable
    ) {
        self.listingArtsBuilder = listingArtsBuilder
        self.sectionsViewCoordinatable = sectionsViewCoordinatable
        super.init(viewController: viewController, interactor: interactor)
    }
}

extension OnSectionsListCoordinator: OnSectionsListCoordinating {
    func openArtsListing(sections: [ArtListSection], listener: OnArtsListListener) {
        let artListingList = sections.map { section in
            listingArtsBuilder.makeOnArtsList(
                section: section,
                listener: listener
            )
        }
        
        let artListBySection = zip(sections, artListingList).map { section, artList in
            (section.identifier, artList.view)
        }
                
        attach(artListingList)
        sectionsViewCoordinatable.displaySection(
            Dictionary(uniqueKeysWithValues: artListBySection)
        )
    }
}
