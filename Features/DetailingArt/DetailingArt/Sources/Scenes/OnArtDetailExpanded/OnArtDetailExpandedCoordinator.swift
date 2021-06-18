import CoreKit
import UIKit

protocol OnArtDetailExpandedCoordinating: AnyObject {
    func openFullSizeImage(image: String, listener: OnImageFullSizeListener)
    func closeFullSize()
}

final class OnArtDetailExpandedCoordinator: ViewableCoordinator {
    private let fullSizeImageBuilder: OnImageFullSizeBuildable
    private let modalRouter: ModalRouting

    init(fullSizeImageBuilder: OnImageFullSizeBuildable,
         modalRouter: ModalRouting,
         viewController: UIViewController,
         interactor: Interacting
    ) {
        self.modalRouter = modalRouter
        self.fullSizeImageBuilder = fullSizeImageBuilder
        super.init(viewController: viewController, interactor: interactor)
    }
}

extension OnArtDetailExpandedCoordinator: OnArtDetailExpandedCoordinating {
    func openFullSizeImage(image: String, listener: OnImageFullSizeListener) {
        let fullSizeImage = fullSizeImageBuilder.makeOnImageFullSize(image: image, listener: listener)
        attach(fullSizeImage)
        modalRouter.present(fullSizeImage, animated: true, presentationStyle: .fullScreen, completion: nil)
    }
    
    func closeFullSize() {
        deattachLast()
        modalRouter.dismiss()
    }
}
