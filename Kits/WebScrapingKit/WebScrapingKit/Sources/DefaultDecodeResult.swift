import Foundation
import WebScrapingKitInterface

public struct DefaultDecodeResult<DecodableType: HTMLDecodable>: DecodeResulting {
    private let elements: [SearchResult]
    
    init(elements: [SearchResult]) {
        self.elements = elements
    }
    
    public func all() throws -> [DecodableType] {
        try elements.map { element in
            try DecodableType.init(container: HTMLContainer(currentElement: element))
        }
    }
    
    public func justOne() throws -> DecodableType {
        guard let firstElement = elements.first else {
            throw HTMLDecoderError.emptyCollection
        }
        
        return try DecodableType.init(container: HTMLContainer(currentElement: firstElement))
    }
}
