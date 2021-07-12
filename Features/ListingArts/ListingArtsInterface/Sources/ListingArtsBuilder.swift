import Foundation
import CoreKit

public protocol ListingArtsBuildable {
    func makeListingArts(listener: ListingArtsListener, isVertical: Bool) -> ViewableCoordinating
}
