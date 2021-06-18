import Foundation

public protocol Parser {
    associatedtype ParsableType
    
    func parse(data: Data, toType type: ParsableType.Type) throws -> ParsableType
}
