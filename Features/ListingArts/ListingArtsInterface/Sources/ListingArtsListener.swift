import Foundation

public protocol ListingArtsListener: AnyObject {
    func pixelArtSelected(_ link: URL)
}
