import Foundation

public protocol Provider {
    associatedtype ReturnType
    
    @discardableResult
    func request(resource: Resource, completion: @escaping ResultCompletion<ReturnType, Error>) -> CancellableTask?
}
