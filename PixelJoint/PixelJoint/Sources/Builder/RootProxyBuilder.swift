import Foundation
import Root
import UIKit
import CoreKit
import Combine
import DetailingArtInterface
import ListingArtsInterface

struct RootProxyBuilder: RootBuildable {
    func makeRoot() -> ViewableCoordinating {
        RootBuilder(externalBuilder: RootExternalBuilder(), externalDepedency: RootExternalDepedency()).makeRoot()
    }
}

private struct RootExternalDepedency: RootExternalDepedencing {
    let storage: LocalStoraging = LocalStorage()
}

private struct RootExternalBuilder: RootExternalBuildable {
    func makeDetailingArt(view: UIViewController,
                          openDetailPublisher: AnyPublisher<URL, Never>,
                          stackRouter: StackRouting) -> Coordinating {
        DetailingArtProxyBuilder().makeDetailingArt(
            view: view,
            openDetailPublisher: openDetailPublisher,
            stackRouter: stackRouter
        )
    }
    
    func makeListingArts(listener: ListingArtsListener) -> ViewableCoordinating {
        ListingArtsProxyBuilder().makeListingArts(listener: listener)
    }
}

private struct LocalStorage: LocalStoraging {
    func save(string: String, for key: String) {
        UserDefaults.standard.set(string, forKey: key)
    }

    func get(key: String) -> String? {
        UserDefaults.standard.string(forKey: key)
    }
}
