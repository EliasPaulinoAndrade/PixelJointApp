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
    func makeListingArts(listener: ListingArtsListener, isVertical: Bool) -> ViewableCoordinating {
        ListingArtsBuilder(
            externalDepedency: ListingArtsDepedency()
        ).makeListingArts(listener: listener, isVertical: isVertical)
    }
}

private struct ListingArtsDepedency: ListingArtsDepedencing {
    var fileProvider: AnyProvider<(data: Data, url: URL)> {
        URLSessionFileProvider(urlSession: .shared).map {
            ($0.data, $0.url)
        }.includeCaching
    }
    
    func htmlProvider<T: HTMLDecodable>(type: T.Type) -> AnyProvider<T> {
        URLSessionProvider(urlSession: .shared)
            .map(keyPath: \.data)
            .includeParsing(parser: HTMLParser<T>())
    }
}
