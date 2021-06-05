import Foundation
import CoreKit
import PuccaInterface

protocol InitialInteracting: AnyObject {
    // Add methods that view should call
    func userTappedClose()
}

typealias InitialListener = PuccaListener

final class InitialInteractor: Interacting {
    private let presenter: InitialPresenting
    weak var coordinator: InitialCoordinating?
    weak var listener: InitialListener?
    
    init(presenter: InitialPresenting) {
        self.presenter = presenter
    }
}
extension InitialInteractor: InitialInteracting {
    // InitialInteracting methods
    
    func userTappedClose() {
        listener?.userClosed()
    }
}
