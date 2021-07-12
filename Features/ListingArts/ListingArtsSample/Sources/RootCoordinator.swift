import CoreKit
import UIKit
import ListingArtsInterface

final class RootCoordinator: ConnectionCoodinator, LauncherCoordinating {
    private lazy var root = ListingArtsProxyBuilder().makeListingArts(
        listener: self,
        isVertical: false
    )
    lazy var viewController: UIViewController = root.viewController
    
    func didLaunch() {
        attach(root)
    }
}

extension RootCoordinator: ListingArtsListener {
    func pixelArtSelected(_ link: URL) {
        print(#file + ": " + #function)
    }
}
