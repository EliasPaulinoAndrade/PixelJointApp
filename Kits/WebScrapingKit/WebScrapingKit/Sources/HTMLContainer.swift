import Foundation
import WebScrapingKitInterface

public struct HTMLContainer: HTMLContaining {
    private let currentElement: SearchResult
    
    init(currentElement: SearchResult) {
        self.currentElement = currentElement
    }
    
    public func decodeSingle() throws -> String {
        switch currentElement {
        case .element(let element):
            return try element.outerHtml()
        case .attributte(let value):
            return value
        }
    }
    
    public func decode<DecodableType: HTMLDecodable>(path: PathElement...,
                                                     type: DecodableType.Type) throws -> DecodeResult<DecodableType> {
        let decodeResult: DefaultDecodeResult<DecodableType>
        switch currentElement {
        case .element(let element):
            let resultElements = try element.searchElements(atPath: path)
            decodeResult = DefaultDecodeResult<DecodableType>(elements: resultElements)
        case .attributte:
            decodeResult = DefaultDecodeResult<DecodableType>(elements: [currentElement])
        }
        
        return DecodeResult(result: decodeResult)
    }
}
