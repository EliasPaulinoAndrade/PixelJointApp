import Foundation
import NetworkingKitInterface
import WebScrapingKitInterface

public typealias ListingArtsDepedencing = HasHTMLProvider & HasFileProvider

public protocol HasHTMLProvider {
    func htmlProvider<T: HTMLDecodable>(type: T.Type) -> AnyProvider<T>
}
