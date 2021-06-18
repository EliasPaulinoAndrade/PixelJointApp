import DetailingArtInterface
import DetailingArt
import Foundation
import CoreKit
import NetworkingKitInterface
import NetworkingKit
import WebScrapingKitInterface
import WebScrapingKit
import UIKit
import Combine

struct DetailingArtProxyBuilder: DetailingArtBuildable {
    func makeDetailingArt(view: UIViewController,
                          openDetailPublisher: AnyPublisher<URL, Never>,
                          stackRouter: StackRouting,
                          listener: DetailingArtListener) -> Coordinating {
        DetailingArtBuilder(externalDepedency: DetailingArtDepedency())
            .makeDetailingArt(
                view: view,
                openDetailPublisher: openDetailPublisher,
                stackRouter: stackRouter,
                listener: listener
            )
    }
}

private struct DetailingArtDepedency: DetailingArtDepedencing {
    var fileProvider: AnyProvider<Data> {
        URLSessionFileProvider(urlSession: .shared).includeCaching
    }

    func htmlProvider<T: HTMLDecodable>(type: T.Type) -> AnyProvider<T> {
        URLSessionProvider(urlSession: .shared)
            .map(keyPath: \.data)
            .includeParsing(parser: HTMLParser<T>())
    }
}
