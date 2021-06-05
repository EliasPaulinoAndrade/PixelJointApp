import Foundation
import CoreKit
import PuccaInterface

public protocol IntProvider {
    func provide() -> Int
}

public final class PuccaBuilder: PuccaBuildable {
    public init(intProvider: IntProvider) {
        print(intProvider.provide())
    }
    public func makePucca(listener: PuccaListener) -> ViewableCoordinating {
        InitialBuilder().makeInitial(listener: listener)
    }
}
