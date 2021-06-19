import Foundation
import CoreKit
import UIKit
import ListingArtsInterface

public struct ListingArtsBuilder: ListingArtsBuildable {
    private let externalDepedency: ListingArtsDepedencing
    
    public init(externalDepedency: ListingArtsDepedencing) {
        self.externalDepedency = externalDepedency
    }
    
    public func makeListingArts(listener: ListingArtsListener) -> ViewableCoordinating {
        return OnSectionsListBuilder(externalDepedency: externalDepedency)
            .makeOnSectionsList(listener: listener)
//        return OnArtsListBuilder(
//            externalDepedency: externalDepedency
//        ).makeOnArtsList(section: ArtListSection(identifier: "showcase", title: "Weekly Showcase"), listener: listener)
    }
}
