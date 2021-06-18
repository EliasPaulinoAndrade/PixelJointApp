import Foundation
import NetworkingKitInterface

final public class URLSessionProvider: Provider {
    public typealias ReturnType = CompleteProviderReturn
    
    private let urlSession: URLSession
    
    public init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    public func request(resource: Resource,
                        completion: @escaping ResultCompletion<ReturnType, Error>) -> CancellableTask? {

        guard let routeRequestURL = urlRequestFrom(resource: resource) else {
            completion(.failure(NetworkError.wrongURL(resource)))
            return nil
        }
        
        let dataTask = urlSession.dataTask(with: routeRequestURL) { [weak self] (data, response, error) in
            self?.handleDataTaskResult(data: data, response: response, error: error, withCompletion: completion)
        }

        dataTask.resume()

        return dataTask
    }

    private func handleDataTaskResult(data: Data?,
                                      response: URLResponse?,
                                      error: Error?,
                                      withCompletion completion: @escaping ResultCompletion<ReturnType, Error>) {
        if let error = error {
            let nsError = error as NSError
            // if th error is caused by request Cancel, dont send it.
            guard nsError.code != -999 else { return }
            completion(.failure(error))
            return
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            completion(.failure(NetworkError.noHttpResponse))
            return
        }
        switch httpResponse.statusCode {
        case 200...299:
            guard let responseData = data else {
                completion(.failure(NetworkError.noResponseData))
                return
            }
            completion(.success(.init(headers: httpResponse.allHeaderFields, data: responseData)))
        default:
            //only responses between 200 and 299 are normal responses.
            completion(.failure(NetworkError.httpError(httpResponse.statusCode)))
        }
    }
    
    private func urlRequestFrom(resource: Resource) -> URLRequest? {
        guard var routeRequestURL = resource.completeRequest else {
            return nil
        }

        routeRequestURL.httpMethod = resource.method.methodIdentifier
        routeRequestURL.timeoutInterval = 60
        routeRequestURL.httpBody = resource.bodyParams.data
        routeRequestURL.setValue(resource.contentType.value, forHTTPHeaderField: "Content-Type")
        routeRequestURL.allHTTPHeaderFields = resource.headerParams
        
        return routeRequestURL
    }
}
