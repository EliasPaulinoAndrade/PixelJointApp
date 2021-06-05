import Foundation
import CoreKit

public protocol PuccaBuildable {
    func makePucca(listener: PuccaListener) -> ViewableCoordinating
}
