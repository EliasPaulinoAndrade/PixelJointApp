import Foundation
import CoreKit

protocol MuchaInteracting: AnyObject {
    // Add methods that view should call
    
    func getFighter()
    func selectedItem()
    func openError(with message: String)
}

final class MuchaInteractor: Interacting {
    private let presenter: MuchaPresenting
    weak var coordinator: MuchaCoordinating?
    private lazy var currentItem: Item = generateNewItem()
    
    init(presenter: MuchaPresenting) {
        self.presenter = presenter
    }
    
    func didStart() {
        present(item: currentItem)
    }
    
    private func present(item: Item) {
        switch item {
        case .fighter(let fighter):
            presenter.presentFighter(fighter)
        case .place(let place):
            presenter.presentPlace(place)
        }
    }
    
    private func generateNewItem() -> Item {
        let generatePlace = Bool.random()
        
        guard generatePlace else {
            let randomFighter = Fighter.allCases.randomElement() ?? .buenaGirl
            return .fighter(randomFighter)
        }
        
        let randomPlace = Place.allCases.randomElement() ?? .academy
        return .place(randomPlace)
    }
}

extension MuchaInteractor: MuchaInteracting {
    // MuchaInteracting methods
    func getFighter() {
        currentItem = generateNewItem()
        present(item: currentItem)
    }
    
    func selectedItem() {
        guard case .place(let place) = currentItem else {
            return presenter.presentFighterError()
        }
        
        coordinator?.openBanner(place: place, listener: self)
    }
    
    func openError(with message: String) {
        coordinator?.openError(message: message)
    }
}

extension MuchaInteractor: BannerListener {
    func cannotShowThisPlace() {
        coordinator?.closeBanner()
        presenter.presentBannerError()
    }
}
