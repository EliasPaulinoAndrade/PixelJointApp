import Foundation

public struct BodyParams {
    public let data: Data?
    
    public init(_ data: Data?) {
        self.data = data
    }
    
    public static func object(_ object: Encodable,
                              encodingStrategy: JSONEncoder.KeyEncodingStrategy) -> BodyParams {
        BodyParams(object.data(encodingStrategy: encodingStrategy))
    }
    
    public static let nothing = BodyParams(nil)
}
