import Foundation

public struct DecodeResult<DecodableType: HTMLDecodable>: DecodeResulting {
    private let _all: () throws -> [DecodableType]
    private let _justOne: () throws -> DecodableType
    
    public init<ResultType: DecodeResulting>(result: ResultType) where ResultType.DecodableType == DecodableType {
        self._all = result.all
        self._justOne = result.justOne
    }
    
    public func all() throws -> [DecodableType] {
        try _all()
    }
    
    public func justOne() throws -> DecodableType {
        try _justOne()
    }
}
