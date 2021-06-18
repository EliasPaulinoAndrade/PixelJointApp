import Foundation

extension Encodable {
    func data(encodingStrategy: JSONEncoder.KeyEncodingStrategy) -> Data? {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.keyEncodingStrategy = encodingStrategy
        return try? jsonEncoder.encode(self)
    }
}
