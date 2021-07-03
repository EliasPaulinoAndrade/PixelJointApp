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
                          stackRouter: StackRouting) -> Coordinating {
        DetailingArtBuilder(externalDepedency: DetailingArtDepedency())
            .makeDetailingArt(
                view: view,
                openDetailPublisher: openDetailPublisher,
                stackRouter: stackRouter
            )
    }
}

private struct HTMLLinkOpenner: HTMLLinkOpenning {
    func open(link: URL) {
        if UIApplication.shared.canOpenURL(link) {
            UIApplication.shared.open(link, options: [:], completionHandler: nil)
        }
    }
}

private struct DetailingArtDepedency: DetailingArtDepedencing {
    var linkOpenned: HTMLLinkOpenning {
        HTMLLinkOpenner()
    }
    
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
