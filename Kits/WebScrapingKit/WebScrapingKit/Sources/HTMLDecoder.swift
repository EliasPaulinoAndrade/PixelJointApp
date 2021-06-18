import Foundation
import WebScrapingKitInterface
import SwiftSoup

public struct HTMLDecoder {
    public init() { }
    
    public func decode<DecoderType: HTMLDecodable>(
        data: Data,
        _ decodableType: DecoderType.Type
    ) throws -> DecoderType {
        
        guard let htmlString = String(data: data, encoding: .utf8) ?? String(data: data, encoding: .iso2022JP) else {
            throw HTMLDecoderError.noHTMLData
        }
        
        let document = try SwiftSoup.parse(htmlString)
        
        return try decodableType.init(container: HTMLContainer(currentElement: .element(document)))
    }
}
