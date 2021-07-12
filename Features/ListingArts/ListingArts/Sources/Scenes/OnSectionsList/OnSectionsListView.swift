import SwiftUI
import UIToolKit

extension OnSectionsListView {
    struct Section: Identifiable, Hashable {
        let id: String
        let title: String
        let systemImage: String
    }
}

struct OnSectionsListView: View {
    private typealias Strings = ListingArtsStrings.OnSectionsList
    @ObservedObject var stateHolder: OnSectionsListViewStateHolder
    
    var body: some View {
        VStack {
            ScrollableSelectionView(
                models: stateHolder.sections,
                aligmentMode: .center,
                selected: $stateHolder.currentSection
            ) { section, isSelected in
                Text(section.title)
                    .fixedSize(horizontal: true, vertical: false)
                    .font(isSelected ? .body.bold() : .body)
                    .foregroundColor(
                        Color(isSelected ? Colors.background1.color :
                                           Colors.text1.color)
                    )
                    .padding(
                        EdgeInsets(
                            top: Spacing.base3.value,
                            leading: Spacing.base4.value,
                            bottom: Spacing.base3.value,
                            trailing: Spacing.base4.value
                        )
                    )
                    .background(
                        Color(isSelected ? Colors.action1.color :
                                           Colors.background3.color)
                    )
                    .clipShape(Capsule())
                    .padding(.horizontal, 8)
            }
            GeometryReader { contextGeometry in
                ScrollableFocusableView(
                    models: stateHolder.sections,
                    allowsDrag: stateHolder.allowsArtListingDragging,
                    spacing: Spacing.base3.value,
                    focused: $stateHolder.currentSection
                ) { section in
                    stateHolder.artLists[section.id]
                        .frame(
                            width: contextGeometry.size.width,
                            height: contextGeometry.size.height
                        )
                }
            }
        }.background(Color(Colors.background2.color))
         .navigationTitle(Strings.pixelJoint)
    }
}
