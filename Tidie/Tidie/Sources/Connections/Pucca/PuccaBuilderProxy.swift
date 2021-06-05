import Pucca
import PuccaInterface
import CoreKit

struct PuccaBuilderProxy: PuccaBuildable, IntProvider {
    func makePucca(listener: PuccaListener) -> ViewableCoordinating {
        PuccaBuilder(intProvider: self).makePucca(listener: listener)
    }
    
    func provide() -> Int {
        1
    }
}
