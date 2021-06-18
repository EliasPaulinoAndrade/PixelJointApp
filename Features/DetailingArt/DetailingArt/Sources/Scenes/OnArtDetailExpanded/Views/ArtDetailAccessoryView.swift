import SwiftUI
import UIToolKit

struct ArtDetailAccessoryView: View {
    let acessories: [Viewable.Accessory]

    var body: some View {
        HStack {
            ForEach(acessories) { acessory in
                HStack {
                    Image(uiImage: acessory.image)
                        .renderingMode(.template)
                    Text(acessory.count)
                }.frame(maxWidth: .infinity)
            }
        }.frame(maxWidth: .infinity)
         .padding(8)
         .overlay(
            Divider()
                .background(Color(UIToolKitAsset.darkBackground.color)),
            alignment: .top
         )
         .overlay(
           Divider()
               .background(Color(UIToolKitAsset.darkBackground.color)),
           alignment: .bottom
         )
    }
}
