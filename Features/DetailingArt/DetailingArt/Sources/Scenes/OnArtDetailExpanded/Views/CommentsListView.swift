import SwiftUI
import NetworkingKitInterface
import UIToolKit

struct CommentsListView: View {
    let comments: [Viewable.Comment]
    let imageProvider: AnyProvider<Data>
    var onCommentAppearAction: ((_ identifier: String) -> Void)?
    
    var body: some View {
        ForEach(comments) { comment in
            HStack(spacing: 8) {
                VStack {
                    AsyncImage(resource: comment.image, provider: imageProvider,
                        imageProvider: { image in
                            Image(uiImage: image)
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
