import UIKit
import UIToolKit

protocol OnImageFullSizePresenting: AnyObject {
    func presentArtImage(_ image: String)
}

final class OnImageFullSizeViewStateHolder: ObservableObject {
    weak var interactor: OnImageFullSizeInteracting?
    
    @Published var imageResource: AsyncImageResource?
    @Published var zoom: CGFloat = 1
}

extension OnImageFullSizeViewStateHolder: OnImageFullSizePresenting {
    func presentArtImage(_ image: String) {
        imageResource = AsyncImageResource(baseURL: PixelJointConstants.baseURL, path: image)
    }
}
