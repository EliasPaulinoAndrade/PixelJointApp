import Foundation
import NetworkingKitInterface

public enum NetworkError: Error, CustomStringConvertible {
    case wrongURL(Resource), noResponseData, noHttpResponse, httpError(Int), unknown
    
    public var description: String {
        switch self {
        case .wrongURL(let wrongRoute):
            return "The request route is wrong: \(wrongRoute)"
        case .noResponseData, .noHttpResponse:
            return "The request response is in a wrong format"
        case .httpError(let errorCode):
            return "The request ended with a HTTP Error of code: \(errorCode)"
        case .unknown:
            return "unkwown error"
        }
    }
}
