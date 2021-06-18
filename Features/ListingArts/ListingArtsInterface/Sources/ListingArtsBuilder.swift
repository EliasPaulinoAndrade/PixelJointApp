import Foundation
import CoreKit

public protocol ListingArtsBuildable {
    func makeListingArts(listener: ListingArtsListener) -> ViewableCoordinating
}
