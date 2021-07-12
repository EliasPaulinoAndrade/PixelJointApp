import Foundation

protocol OnSectionsListViewable: AnyObject {    
    func displaySections(_ sections: [OnSectionsListView.Section])
    func displayCurrentSection(_ section: OnSectionsListView.Section)
}

protocol OnSectionsListViewCoordinatable: AnyObject {
    func displaySection(_ sections: [String: OnArtsListView])
}

final class OnSectionsListViewStateHolder: ObservableObject {    
    @Published var sections: [OnSectionsListView.Section] = []
    @Published var artLists: [String: OnArtsListView] = [:]
    @Published var currentSection: OnSectionsListView.Section = defaultSection
    @Published var allowsArtListingDragging: Bool = true
    
    private static let defaultSection = OnSectionsListView.Section(
        id: "",
        title: "",
        systemImage: "burn"
    )
}

extension OnSectionsListViewStateHolder: OnSectionsListViewable {
    func displaySections(_ sections: [OnSectionsListView.Section]) {
        self.sections = sections
    }
    
    func displayCurrentSection(_ section: OnSectionsListView.Section) {
        self.currentSection = section
    }
}

extension OnSectionsListViewStateHolder: OnSectionsListViewCoordinatable {
    func displaySection(_ sections: [String: OnArtsListView]) {
        artLists = sections
    }
}
