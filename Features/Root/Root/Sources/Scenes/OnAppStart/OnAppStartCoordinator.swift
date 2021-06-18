import CoreKit
import UIKit
import ListingArtsInterface
import DetailingArtInterface
import Combine

protocol OnAppStartCoordinating: AnyObject {
    func openListingArts(listener: ListingArtsListener)
    func openDetailingArt(openDetailPublisher: AnyPublisher<URL, Never>, listener: DetailingArtListener)
    func closeDetailingArt()
}

final class OnAppStartCoordinator: ViewableCoordinator {
    private let stackRouter: StackRouting
    private let listingArtsBuilder: ListingArtsBuildable
    private let detailingArtBuilder: DetailingArtBuildable
    
    init(listingArtsBuilder: ListingArtsBuildable,
         detailingArtBuilder: DetailingArtBuildable,
         stackRouter: StackRouting,
         viewController: UIViewController,
         interactor: Interacting
    ) {
        self.listingArtsBuilder = listingArtsBuilder
        self.detailingArtBuilder = detailingArtBuilder
        self.stackRouter = stackRouter
        super.init(viewController: viewController, interactor: interactor)
    }
}

extension OnAppStartCoordinator: OnAppStartCoordinating {
    func openListingArts(listener: ListingArtsListener) {
        let listingArts = listingArtsBuilder.makeListingArts(listener: listener)
        
        attach(listingArts)
        stackRouter.add(coordinator: listingArts, height: nil, priority: nil)
    }
    
    func openDetailingArt(openDetailPublisher: AnyPublisher<URL, Never>, listener: DetailingArtListener) {
        let detailingArt = detailingArtBuilder.makeDetailingArt(
            view: viewController,
            openDetailPublisher: openDetailPublisher,
            stackRouter: stackRouter,
            listener: listener
        )
        
        attach(detailingArt)
    }
    
    func closeDetailingArt() {
        deattachLast()
    }
}
