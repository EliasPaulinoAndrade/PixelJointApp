import Foundation
import WebScrapingKitInterface
import NetworkingKitInterface

public struct HTMLParser<ParsableType: HTMLDecodable>: Parser {
    public init() { }
    public func parse(data: Data, toType type: ParsableType.Type) throws -> ParsableType {
        let htmlDecoder = HTMLDecoder()
        
        return try htmlDecoder.decode(data: data, type)
    }
}
