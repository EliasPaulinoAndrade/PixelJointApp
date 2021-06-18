import SwiftUI
import NetworkingKitInterface
import UIToolKit
import SDWebImageSwiftUI

struct ArtDetailImage: View {
    let imageResource: AsyncImageResource
    let imageProvider: AnyProvider<Data>
        
    var body: some View {
        AsyncImage(
            resource: imageResource,
            provider: imageProvider,
            imageProvider: { image in
                GeometryReader { geometry in
                    ZStack {
                        let url = URL(string: imageResource.baseURL.absoluteString + imageResource.path)
                       
                    
                        Image(uiImage: image)
                            .resizable()
                            .opacity(0.5)
                            .blur(radius: 20)

                        let isBigImage = image.size.width > geometry.size.width ||
                                         image.size.height > geometry.size.height

                        if isBigImage {
                            WebImage(url: url)
                                .resizable()
                                .scaledToFit()
                        } else {
                            WebImage(url: url)
                        }
                        
                        
//                        Image(uiImage: image)
//                            .resizable()
//                            .opacity(0.5)
//                            .blur(radius: 20)
//
//                        let isBigImage = image.size.width > geometry.size.width ||
//                                         image.size.height > geometry.size.height
//
//                        if isBigImage {
//                            Image(uiImage: image)
//                                .resizable()
//                                .scaledToFit()
//                        } else {
//                            Image(uiImage: image)
//                        }
                    }
                }
            },
            placeHolderProvider: {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        ).frame(maxWidth: .infinity)
         .frame(height: 200)
    }
}
