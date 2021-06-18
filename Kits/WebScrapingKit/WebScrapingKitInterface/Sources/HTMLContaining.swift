import Foundation

public protocol HTMLContaining {
    func decodeSingle() throws -> String
    func decode<DecodableType: HTMLDecodable>(
        path: PathElement...,
        type: DecodableType.Type) throws -> DecodeResult<DecodableType>
}
