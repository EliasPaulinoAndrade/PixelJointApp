import Foundation
import NetworkingKitInterface

final public class URLSessionFileProvider: Provider {
    public typealias ReturnType = CompleteFileProviderReturn
    
    private let urlSession: URLSession
    
    public init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
   
    @discardableResult
    public func request(resource: Resource,
                        completion: @escaping (Result<CompleteFileProviderReturn, Error>) -> Void) -> CancellableTask? {
        guard let routeRequestURL = resource.completeURL else {
            completion(.failure(NetworkError.wrongURL(resource)))
            return nil
        }
        
        let downloadTask = urlSession.downloadTask(with: routeRequestURL) { (url, _, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let responseUrl = url,
                  let fileData = try? Data(contentsOf: responseUrl) else {
                completion(.failure(NetworkError.noResponseData))
                return
            }
            
            completion(.success(CompleteFileProviderReturn(data: fileData, url: responseUrl)))
        }
        
        downloadTask.resume()
        
        return downloadTask
    }
}
