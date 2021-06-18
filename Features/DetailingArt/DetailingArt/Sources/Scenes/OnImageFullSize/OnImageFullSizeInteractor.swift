import Foundation
import CoreKit
protocol OnImageFullSizeInteracting: AnyObject {
    func closeSelected()
}

protocol OnImageFullSizeListener: AnyObject {
    func userFinished()
}

final class OnImageFullSizeInteractor: Interacting {
    private let presenter: OnImageFullSizePresenting
    weak var listener: OnImageFullSizeListener?
    
    private let artImage: String
    
    init(image: String, presenter: OnImageFullSizePresenting) {
        self.presenter = presenter
        self.artImage = image
    }
    
    func didStart() {
        presenter.presentArtImage(artImage)
    }
}
extension OnImageFullSizeInteractor: OnImageFullSizeInteracting {
    func closeSelected() {
        listener?.userFinished()
    }
}
