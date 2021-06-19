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
        HStack(spacing: 0) {
            Image(systemName: stateHolder.currentSection.systemImage)
                .foregroundColor(Color(UIToolKitAsset.text.color))
            Text(stateHolder.currentSection.title)
                .font(.body).bold()
                .padding(8)
                .foregroundColor(Color(UIToolKitAsset.text.color))
            Spacer()
            Button(
                action: {
                    stateHolder.interactor?.switchButtonSelected()
                },
                label: {
                    Image(systemName: "arrow.right.arrow.left.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            ).foregroundColor(Color(UIToolKitAsset.link.color))
        }.padding(16)
         .background(Color(UIToolKitAsset.darkBackground.color))
         .sheet(isPresented: $stateHolder.isShowingSectionSelection) {
            VStack {
                Text(Strings.sectionSelection)
                    .font(.title).bold()
                Spacer()
                Picker(Strings.pleaseChooseSection, selection: $stateHolder.currentSection) {
                    ForEach(stateHolder.sections) { section in
                        Text(section.title).tag(section)
                    }
                }.onChange(of: stateHolder.currentSection) { currentSelection in
                    stateHolder.interactor?.sectionSelected(identifier: currentSelection.id)
                }
                Spacer()
                Button(
                    action: {
                        stateHolder.interactor?.closeButtonSelected()
                    },
                    label: {
                        Group {
                            Text(Strings.close)
                                .font(.body).bold()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color(UIToolKitAsset.darkBackground.color))
                                .padding(8)
                        }.background(Color(UIToolKitAsset.link.color))
                         .cornerRadius(8)
                         .padding(8)
                    }
                )
            }.padding()
             .foregroundColor(Color(UIToolKitAsset.text.color))
         }
    }
}
