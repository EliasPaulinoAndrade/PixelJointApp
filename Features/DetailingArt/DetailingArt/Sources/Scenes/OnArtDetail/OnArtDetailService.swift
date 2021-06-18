import Foundation
import NetworkingKitInterface

protocol OnArtDetailServicing {
    func getArtDetail(link: URL, completion: @escaping ResultCompletion<PixelArtDetail, Error>)
}

final class OnArtDetailService: OnArtDetailServicing {
    private let provider: AnyProvider<PixelArtDetail>
    
    init(provider: AnyProvider<PixelArtDetail>) {
        self.provider = provider
    }
    
    func getArtDetail(link: URL, completion: @escaping ResultCompletion<PixelArtDetail, Error>) {
        provider.request(resource: OnArtDetailResource(path: link.absoluteString)) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
