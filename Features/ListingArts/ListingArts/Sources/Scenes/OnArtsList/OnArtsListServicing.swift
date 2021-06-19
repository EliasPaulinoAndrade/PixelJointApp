import Foundation
import NetworkingKitInterface

protocol OnArtsListServicing {
    func getArts(page: Int, completion: @escaping ResultCompletion<GalleryPage, Error>)
}

final class OnArtsListService: OnArtsListServicing {
    private let provider: AnyProvider<PixelArtGallery>
    private let section: ArtListSection
    
    init(provider: AnyProvider<PixelArtGallery>, section: ArtListSection) {
        self.provider = provider
        self.section = section
    }
    
    func getArts(page: Int, completion: @escaping (Result<GalleryPage, Error>) -> Void) {
        let section = self.section
        let provider = self.provider
        provider.request(resource: OnArtsListResource(page: 1, section: section)) { result in
            guard case .success = result else {
                return completion(result.map { gallery in
                    GalleryPage(gallery: gallery, pageIndex: page)
                })
            }
            provider.request(resource: OnArtsListResource(page: page, section: section)) { result in
                DispatchQueue.main.async {
                    completion(result.map { gallery in
                        GalleryPage(gallery: gallery, pageIndex: page)
                    })
                }
            }
        }
    }
}
