import Foundation
import NetworkingKitInterface

public final class CachableObjectHolder<ObjectType>: NSObject {
    let object: ObjectType
    init(object: ObjectType) {
        self.object = object
    }
}

class CacheProvider<ReturnType>: Provider {
    private let cachableProvider: AnyProvider<ReturnType>
    private let cacheStore: NSCache<NSString, CachableObjectHolder<ReturnType>>
    
    public init(cachableProvider: AnyProvider<ReturnType>,
                cacheStore: NSCache<NSString, CachableObjectHolder<ReturnType>> = .init()) {
        self.cachableProvider = cachableProvider
        self.cacheStore = cacheStore
    }

    func request(resource: Resource, completion: @escaping (Result<ReturnType, Error>) -> Void) -> CancellableTask? {
        let cacheKey = resource.completeURL?.absoluteString ?? resource.baseURL.absoluteString
        if let cachedObject = cacheStore.object(forKey: cacheKey as NSString) {
            completion(.success(cachedObject.object))
            return nil
        } else {
            let cancellableTask = self.cachableProvider.request(resource: resource) { [weak self] result in
                switch result {
                case .success(let resultObject):
                    self?.cacheStore.setObject(
                        CachableObjectHolder(object: resultObject),
                        forKey: resource.baseURL.absoluteString as NSString
                    )
                    completion(.success(resultObject))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
            
            return cancellableTask
        }
    }
}
