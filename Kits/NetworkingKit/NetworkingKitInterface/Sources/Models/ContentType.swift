import Foundation

public struct ContentType {
    public let value: String
    
    public init(_ value: String) {
        self.value = value
    }

    public static let jsonUTF8 = ContentType("application/json; charset=utf-8")
    public static let json = ContentType("application/json")
    public static let formUrlEncoded = ContentType("application/x-www-form-urlencoded")
    public static func multipart(boundary: String) -> ContentType {
        ContentType("multipart/form-data; boundary=\(boundary)")
    }
}
