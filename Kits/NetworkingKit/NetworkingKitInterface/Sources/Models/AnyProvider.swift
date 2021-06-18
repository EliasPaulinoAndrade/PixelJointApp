import Foundation

public struct AnyProvider<ReturnType>: Provider {
    public typealias AnyRequest = (Resource, @escaping ResultCompletion<ReturnType, Error>) -> CancellableTask?
    
    private let anyRequest: AnyRequest

    public init<ProviderType: Provider>(provider: ProviderType) where ProviderType.ReturnType == ReturnType {
        self.anyRequest = provider.request
    }
    
    public init(request: @escaping AnyRequest) {
        self.anyRequest = request
    }

    @discardableResult
    public func request(resource: Resource,
                        completion: @escaping ResultCompletion<ReturnType, Error>) -> CancellableTask? {
        anyRequest(resource, completion)
    }
}
