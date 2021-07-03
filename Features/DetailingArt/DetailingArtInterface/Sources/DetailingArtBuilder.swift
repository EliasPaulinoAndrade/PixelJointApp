import Foundation
import CoreKit
import UIKit
import Combine

public protocol DetailingArtBuildable {
    func makeDetailingArt(view: UIViewController,
                          openDetailPublisher: AnyPublisher<URL, Never>,
                          stackRouter: StackRouting) -> Coordinating
}
