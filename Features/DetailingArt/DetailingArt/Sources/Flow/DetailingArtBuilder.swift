import Foundation
import DetailingArtInterface
import CoreKit
import UIKit
import Combine

public struct DetailingArtBuilder: DetailingArtBuildable {
    let externalDepedency: DetailingArtDepedencing
    
    public init(externalDepedency: DetailingArtDepedencing) {
        self.externalDepedency = externalDepedency
    }
    
    public func makeDetailingArt(view: UIViewController,
                                 openDetailPublisher: AnyPublisher<URL, Never>,
                                 stackRouter: StackRouting,
                                 listener: DetailingArtListener) -> Coordinating {
        
        OnArtDetailBuilder(view: view, externalDepedency: externalDepedency)
            .makeOnArtDetail(openDetailPublisher: openDetailPublisher, stackRouter: stackRouter, listener: listener)
    }
}
