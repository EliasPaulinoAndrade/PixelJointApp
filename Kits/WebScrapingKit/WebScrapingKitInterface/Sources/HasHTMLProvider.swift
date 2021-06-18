import Foundation
import NetworkingKitInterface

public protocol HasHTMLProvider {
    func htmlProvider<T: HTMLDecodable>(type: T.Type) -> AnyProvider<T>
}
