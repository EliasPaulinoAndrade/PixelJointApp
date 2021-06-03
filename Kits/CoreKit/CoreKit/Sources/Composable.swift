import Foundation
//
//public protocol Composable: AnyObject {
//    associatedtype ChildType: AnyObject
//    var childComposables: [ChildType] { get set }
//    
//    func attach(_ composable: ChildType)
//    func deattach(_ composable: ChildType)
//    func deattach<ComposableType>(type: ComposableType.Type)
//    func deattachLast()
//    func deattachAll()
//}
//
//public extension Composable {
//    func attach(_ composable: ChildType) {
//        childComposables.append(composable)
//    }
//    
//    func deattach(_ composables: [ChildType]) {
//        composables.forEach(deattach)
//    }
//    
//    func deattach(_ composable: ChildType) {
//        childComposables.removeAll {
//            composable === $0
//        }
//    }
//    
//    func deattach<ComposableType>(type: ComposableType.Type) {
//        childComposables.removeAll {
//            $0 is ComposableType
//        }
//    }
//    
//    func deattachLast() {
//        guard let lastCoordinator = childComposables.last else {
//            return
//        }
//        
//        deattach(lastCoordinator)
//    }
//    
//    func deattachAll() {
//        childComposables.forEach(deattach)
//    }
//}
