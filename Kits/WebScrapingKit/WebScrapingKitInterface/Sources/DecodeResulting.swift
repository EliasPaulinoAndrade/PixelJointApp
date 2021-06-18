import Foundation

public protocol DecodeResulting {
    associatedtype DecodableType: HTMLDecodable
    func all() throws -> [DecodableType]
    func justOne() throws -> DecodableType
}
