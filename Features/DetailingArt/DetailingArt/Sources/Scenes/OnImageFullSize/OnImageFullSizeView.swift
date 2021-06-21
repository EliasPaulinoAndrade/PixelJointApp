import UIKit
import SwiftUI
import NetworkingKitInterface
import UIToolKit
import SDWebImageSwiftUI

private enum Constant {
    static let zoomLowerBound: String = "0.5"
    static let zoomUpperBound: String = "5"
    static let zoomRange: ClosedRange<CGFloat> = 0.5...5
    
    enum Layout {
        static let buttonSize: CGFloat = 40
    }
}

struct OnImageFullSizeView: View {
    private typealias Strings = DetailingArtStrings.OnImageFullSize
    
    @ObservedObject private var stateHolder: OnImageFullSizeViewStateHolder
    private let imageProvider: AnyProvider<(data: Data, url: URL)>

    var body: some View {
        if let imageResource = stateHolder.imageResource {
            VStack(spacing: 0) {
                ZStack {
                    detailImage(resource: imageResource)
                    closeButton()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                        .padding(8)
                }
                zoomControlMenu()
            }.statusBar(hidden: true)
             .background(Color.black.edgesIgnoringSafeArea(.all))
        } else {
            ProgressView()
        }
    }
    
    init(stateHolder: OnImageFullSizeViewStateHolder, imageProvider: AnyProvider<(data: Data, url: URL)>) {
        self.stateHolder = stateHolder
        self.imageProvider = imageProvider
    }
    
    private func zoomControlMenu() -> some View {
        VStack {
            Text(Strings.xTimes(String(format: "%.2f", stateHolder.zoom)))
                .font(.title).bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(8)
            HStack {
                Image(systemName: "plus.magnifyingglass")
                Slider(
                    value: $stateHolder.zoom,
                    in: Constant.zoomRange,
                    minimumValueLabel: Text(Constant.zoomLowerBound),
                    maximumValueLabel: Text(Constant.zoomUpperBound),
                    label: { }
                )
            }.padding(8)
        }.background(Color(UIToolKitAsset.extraDark.color).ignoresSafeArea())
         .foregroundColor(Color(UIToolKitAsset.text.color))
    }
    
    @ViewBuilder
    private func detailImage(resource: AsyncImageResource) -> some View {
        ScrollView([.horizontal, .vertical], showsIndicators: false) {
            AsyncImage(
                resource: resource,
                provider: imageProvider,
                imageProvider: { image, _, url in
                    WebImage(url: url)
                        .interpolation(.none)
                        .antialiased(false)
                        .resizable()
                        .frame(
                            width: image.size.width * stateHolder.zoom,
                            height: image.size.height * stateHolder.zoom,
                            alignment: .center
                        )
                },
                placeHolderProvider: {
                    ProgressView()
                }
            )
        }
    }
    
    private func closeButton() -> some View {
        Button(
            action: {
                stateHolder.interactor?.closeSelected()
            },
            label: {
                ZStack {
                    Circle()
                        .frame(
                            width: Constant.Layout.buttonSize,
                            height: Constant.Layout.buttonSize
                        )
                        .blendMode(.darken)
                        .opacity(0.3)
                    Circle()
                        .strokeBorder(lineWidth: 2)
                        .background(Image(systemName: "xmark").font(.title2.weight(.bold)))
                        .frame(
                            width: Constant.Layout.buttonSize,
                            height: Constant.Layout.buttonSize
                        )
                        .blendMode(.difference)
                }
            }
        ).foregroundColor(Color.white)
    }
}
