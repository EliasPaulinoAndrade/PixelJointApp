import Foundation

extension URL: HTMLDecodable {
    public enum DecodeError: Error {
        case couldNotDecodeURL
    }
    
    public init(container: HTMLContaining) throws {
        guard let url = URL(string: try container.decodeSingle()) else {
            throw DecodeError.couldNotDecodeURL
        }
        self = url
    }
}
