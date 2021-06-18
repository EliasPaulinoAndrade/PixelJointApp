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
        return OnArtsListBuilder(
            externalDepedency: externalDepedency
        ).makeOnArtsList(listener: listener)
    }
}