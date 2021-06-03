import Foundation
import CoreKit
protocol InspectorInteracting: AnyObject {
    // Add methods that view should call
    func getNumber()
    func closeButtonTapped()
}

public protocol InspectorListener: AnyObject {
    func userDidFinish()
}

final class InspectorInteractor: Interacting {
    private let presenter: InspectorPresenting
    weak var coordinator: InspectorCoordinating?
    weak var listener: InspectorListener?
    
    init(presenter: InspectorPresenting) {
        self.presenter = presenter
    }
}

extension InspectorInteractor: InspectorInteracting {
    // InspectorInteracting methods
    
    func getNumber() {
        presenter.showText(String(Int.random(in: 0..<10000)))
    }
    
    func closeButtonTapped() {
        listener?.userDidFinish()
    }
}
