import Foundation

protocol OnSectionsListViewable: AnyObject {
    var isShowingSectionSelection: Bool { get set }
    
    func displaySections(_ sections: [OnSectionsListView.Section])
    func displayCurrentSection(_ section: OnSectionsListView.Section)
}

final class OnSectionsListViewStateHolder: ObservableObject {
    weak var interactor: OnSectionsListInteracting?
    
    @Published var sections: [OnSectionsListView.Section] = []
    @Published var currentSection: OnSectionsListView.Section = OnSectionsListView.Section(
        id: "",
        title: "",
        systemImage: "burn"
    )
    @Published var isShowingSectionSelection = false
}

extension OnSectionsListViewStateHolder: OnSectionsListViewable {
    func displaySections(_ sections: [OnSectionsListView.Section]) {
        self.sections = sections
    }
    
    func displayCurrentSection(_ section: OnSectionsListView.Section) {
        self.currentSection = section
    }
}
