import Foundation
import CoreKit
import ListingArtsInterface

protocol OnSectionsListInteracting: AnyObject {
    func sectionSelected(identifier: String)
    func switchButtonSelected()
    func closeButtonSelected()
}

typealias OnSectionsListListener = ListingArtsListener

final class OnSectionsListInteractor: Interacting {
    private lazy var sections = getAllSections()
    private let presenter: OnSectionsListPresenting
    weak var coordinator: OnSectionsListCoordinating?
    weak var listener: OnSectionsListListener?
    
    init(presenter: OnSectionsListPresenting) {
        self.presenter = presenter
    }
    
    func didStart() {
        coordinator?.openArtsListing(sections: sections, listener: self)
        presenter.presentSections(sections)
        presenter.presentCurrentSection(section: sections.first)
    }
    
    private func getAllSections() -> [ArtListSection] {
        ArtListSectionType.allCases.map { sectionType -> ArtListSection in
            switch sectionType {
            case .highestRated:
                return ArtListSection(identifier: "rating", type: sectionType)
            case .weeklyShowcase:
                return ArtListSection(identifier: "showcase", type: sectionType)
            case .newest:
                return ArtListSection(identifier: "date", type: sectionType)
            case .mostFavorited:
                return ArtListSection(identifier: "favorites", type: sectionType)
            }
        }
    }
}

extension OnSectionsListInteractor: OnSectionsListInteracting {
    func switchButtonSelected() {
        presenter.presentSectionSelection()
    }
    
    func closeButtonSelected() {
        presenter.hideSectionSelection()
    }
    
    func sectionSelected(identifier: String) {
        coordinator?.goToSection(identifier: identifier)
    }
}

extension OnSectionsListInteractor: OnArtsListListener {
    func pixelArtSelected(_ link: URL) {
        listener?.pixelArtSelected(link)
    }
}

extension OnSectionsListInteractor: TabRouterDelegate {
    func userDidChangeTab(originalIdentifier: String, targetIdentifier: String) {
        let selectedSection = sections.first { $0.identifier == targetIdentifier }
        presenter.presentCurrentSection(section: selectedSection)
    }
}
