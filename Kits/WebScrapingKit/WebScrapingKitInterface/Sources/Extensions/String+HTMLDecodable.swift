import Foundation

extension String: HTMLDecodable {
    public init(container: HTMLContaining) throws {
        self = try container.decodeSingle()
    }
}
