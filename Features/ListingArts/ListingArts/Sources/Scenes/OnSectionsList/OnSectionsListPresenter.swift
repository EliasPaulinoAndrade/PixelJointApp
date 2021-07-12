import UIKit

protocol OnSectionsListPresenting: AnyObject {
    func presentSections(_ sections: [ArtListSection])
    func presentCurrentSection(section: ArtListSection?)
}

final class OnSectionsListPresenter {
    private typealias Strings = ListingArtsStrings.OnSectionsList
    private let view: OnSectionsListViewable
    init(view: OnSectionsListViewable) {
        self.view = view
    }
    
    private func getViewableSection(for section: ArtListSection?) -> OnSectionsListView.Section? {
        guard let section = section else {
            return nil
        }
        
        let (image, title) = getImageAndTitleFrom(sectionType: section.type)
        
        return OnSectionsListView.Section(
            id: section.identifier,
            title: title,
            systemImage: image
        )
    }
    
    private func getImageAndTitleFrom(sectionType: ArtListSectionType) -> (image: String, title: String) {
        switch sectionType {
        case .highestRated:
            return ("hand.thumbsup.fill", Strings.highestRating)
        case .weeklyShowcase:
            return ("calendar.circle.fill", Strings.weeklyShowcase)
        case .newest:
            return ("clock.fill", Strings.newest)
        case .mostFavorited:
            return ("heart.fill", Strings.mostFavorites)
        }
    }
}

extension OnSectionsListPresenter: OnSectionsListPresenting {
    func presentCurrentSection(section: ArtListSection?) {
        guard let section = getViewableSection(for: section) else {
            return
        }
        view.displayCurrentSection(section)
    }
    
    func presentSections(_ sections: [ArtListSection]) {
        let viewableSections = sections.compactMap(getViewableSection)
        view.displaySections(viewableSections)
    }
}
