import Foundation
import NetworkingKitInterface

protocol OnArtsListServicing {
    func getArts(page: Int, completion: @escaping ResultCompletion<GalleryPage, Error>)
}

final class OnArtsListService: OnArtsListServicing {
    private let provider: AnyProvider<PixelArtGallery>
    
    init(provider: AnyProvider<PixelArtGallery>) {
        self.provider = provider
    }
    
    func getArts(page: Int, completion: @escaping (Result<GalleryPage, Error>) -> Void) {
        provider.request(resource: OnArtsListResource(page: String(page))) { result in
            DispatchQueue.main.async {
                completion(result.map { gallery in
                    GalleryPage(gallery: gallery, pageIndex: page)
                })
            }
        }
    }
}
