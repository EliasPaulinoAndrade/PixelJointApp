import SwiftUI
import NetworkingKitInterface
import UIToolKit
import SDWebImageSwiftUI

struct CommentsListView: View {
    let comments: [Viewable.Comment]
    let imageProvider: AnyProvider<(data: Data, url: URL)>
    var onCommentAppearAction: ((_ identifier: String) -> Void)?
    
    var body: some View {
        ForEach(comments) { comment in
            HStack(spacing: 8) {
                VStack {
                    AsyncImage(resource: comment.image, provider: imageProvider,
                        imageProvider: { _, _, url in
                            WebImage(url: url)
                        },
                        placeHolderProvider: {
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    ).frame(width: 64, height: 64)
                    Spacer()
                }
                VStack {
                    Text(comment.author)
                        .font(.body).bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(comment.message)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }.frame(maxHeight: .infinity, alignment: .top)
            }.padding([.top, .bottom], 8)
             .onAppear {
                onCommentAppearAction?(comment.id)
             }
            Divider()
                .background(Color(UIToolKitAsset.darkBackground.color))
        }.foregroundColor(Color(UIToolKitAsset.text.color))
    }
    
    func onCommentAppear(perform: ((_ identifier: String) -> Void)?) -> CommentsListView {
        var selfCopy = self
        selfCopy.onCommentAppearAction = perform
        return selfCopy
    }
}
