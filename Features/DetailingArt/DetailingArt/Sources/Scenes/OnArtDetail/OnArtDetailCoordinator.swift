import CoreKit
import Combine
import Foundation

protocol OnArtDetailCoordinating: AnyObject {
    typealias PublisherResult = Result<PixelArtInfo, Error>
    
    func openExpandedDetail(artDetail: ArtDetailInfoPublisher,
                            listener: OnArtDetailExpandedListener)
    func openMinimizedDetail(artDetail: ArtDetailInfoPublisher,
                             listener: OnArtDetailMinimizedListener)
    func closeExpandedDetail()
}

final class OnArtDetailCoordinator: Coordinator {
    private let modalRouter: ModalRouting
    private let stackRouter: StackRouting
    private let artDetailExpandedBuilder: OnArtDetailExpandedBuildable
    private let artDetailMinimizedBuilder: OnArtDetailMinimizedBuildable
    
    init(modalRouter: ModalRouting,
         stackRouter: StackRouting,
         artDetailExpandedBuilder: OnArtDetailExpandedBuildable,
         artDetailMinimizedBuilder: OnArtDetailMinimizedBuildable,
         interactor: Interacting
    ) {
        self.modalRouter = modalRouter
        self.stackRouter = stackRouter
        self.artDetailExpandedBuilder = artDetailExpandedBuilder
        self.artDetailMinimizedBuilder = artDetailMinimizedBuilder
        super.init(interactor: interactor)
    }
}

extension OnArtDetailCoordinator: OnArtDetailCoordinating {
    func openMinimizedDetail(artDetail: ArtDetailInfoPublisher,
                             listener: OnArtDetailMinimizedListener) {
        let minimizedDetail = artDetailMinimizedBuilder.makeOnArtDetailMinimized(
            listener: listener,
            artDetailPublisher: artDetail
        )
        
        attach(minimizedDetail)
        stackRouter.add(coordinator: minimizedDetail, height: nil, priority: .required)
    }
    
    func openExpandedDetail(artDetail: ArtDetailInfoPublisher,
                            listener: OnArtDetailExpandedListener) {
        let expandedDetail = artDetailExpandedBuilder.makeOnArtDetail(
            artDetailPublisher: artDetail,
            listener: listener
        )
        
        attach(expandedDetail)
        modalRouter.present(expandedDetail)
    }
    
    func closeExpandedDetail() {
        deattachLast()
        modalRouter.dismiss()
    }
}

extension OnArtDetailCoordinator: ModalRouterDelegate {
    func userDidPopViewControllers(of coordinators: [ViewableCoordinating]) {
        deattach(coordinators)
    }
}
