import Foundation
import NetworkingKitInterface

protocol OnArtDetailExpandedServicing {
    func getComments(artURL: URL, pageIndex: Int, completion: @escaping ResultCompletion<CommentPage, Error>)
}

final class OnArtDetailExpandedService: OnArtDetailExpandedServicing {
    private let provider: AnyProvider<CommentPage>
    
    init(provider: AnyProvider<CommentPage>) {
        self.provider = provider
    }
    
    func getComments(artURL: URL, pageIndex: Int, completion: @escaping ResultCompletion<CommentPage, Error>) {
        provider.request(resource: OnArtDetailResource(path: artURL.absoluteString, page: pageIndex)) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
