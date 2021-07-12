import Foundation
import CoreKit
import ListingArtsInterface

typealias OnSectionsListListener = ListingArtsListener

final class OnSectionsListInteractor: Interacting {
    private lazy var sections = getAllSections()
    private let presenter: OnSectionsListPresenting
    private lazy var currentSectionID = sections.first?.identifier
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

extension OnSectionsListInteractor: OnArtsListListener {
    func pixelArtSelected(_ link: URL) {
        listener?.pixelArtSelected(link)
    }
}
