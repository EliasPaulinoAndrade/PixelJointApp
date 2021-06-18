import Foundation
import NetworkingKitInterface

public struct JSONParser<ParsableType: Decodable>: Parser {
    let jsonDecoder: JSONDecoder
    
    public init(jsonDecoder: JSONDecoder = .init()) {
        self.jsonDecoder = jsonDecoder
    }

    public func parse(data: Data, toType type: ParsableType.Type) throws -> ParsableType {
        let typeInstance = try jsonDecoder.decode(type, from: data)
        return typeInstance
    }
}
