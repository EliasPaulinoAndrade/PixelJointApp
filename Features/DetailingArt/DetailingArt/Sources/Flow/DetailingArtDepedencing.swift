import Foundation
import NetworkingKitInterface
import WebScrapingKitInterface

public typealias DetailingArtDepedencing = HasFileProvider & HasHTMLProvider & HasHTMLLinkOpenner

public protocol HasHTMLProvider {
    func htmlProvider<T: HTMLDecodable>(type: T.Type) -> AnyProvider<T>
}

public protocol HasHTMLLinkOpenner {
    var linkOpenned: HTMLLinkOpenning { get }
}

public protocol HTMLLinkOpenning {
    func open(link: URL)
}
