import Foundation
import ListingArts
import CoreKit
import WebScrapingKit
import NetworkingKit
import WebScrapingKitInterface
import NetworkingKitInterface
import ListingArtsInterface
import Combine
import UIKit

struct ListingArtsProxyBuilder: ListingArtsBuildable {
    func makeListingArts(listener: ListingArtsListener) -> ViewableCoordinating {
        return ListingArtsBuilder(
            externalDepedency: ListingArtsDepedency()
        ).makeListingArts(listener: listener)
    }
}

private struct ListingArtsDepedency: ListingArtsDepedencing {
    var fileProvider: AnyProvider<Data> {
        URLSessionFileProvider(urlSession: .shared).includeCaching
    }
    
    func htmlProvider<T: HTMLDecodable>(type: T.Type) -> AnyProvider<T> {
        URLSessionProvider(urlSession: .shared)
            .map(keyPath: \.data)
            .includeParsing(parser: HTMLParser<T>())
    }
}
