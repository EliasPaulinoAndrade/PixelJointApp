import Foundation

public protocol Resource {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var urlParams: [QueryItem] { get }
    var headerParams: [String: String]? { get }
    var bodyParams: BodyParams { get }
    var contentType: ContentType { get }
    var cookieAcceptPolicy: HTTPCookie.AcceptPolicy { get }
}
