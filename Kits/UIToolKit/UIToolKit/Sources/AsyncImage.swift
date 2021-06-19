import SwiftUI
import NetworkingKitInterface
import UIKit

public struct AsyncImage<PlaceHolderType: View, ImageType: View>: View {
    @State private var image: UIImage?
    @State private var isShowingPlaceHolder = true
    @State private var cancellable: CancellableTask?
    private let provider: AnyProvider<Data>
    private let resource: AsyncImageResource
    private let placeHolderProvider: () -> PlaceHolderType
    private let imageProvider: (UIImage) -> ImageType
    
    public init(resource: AsyncImageResource,
                provider: AnyProvider<Data>,
                @ViewBuilder imageProvider: @escaping (UIImage) -> ImageType,
                @ViewBuilder placeHolderProvider: @escaping () -> PlaceHolderType) {
        self.provider = provider
        self.resource = resource
        self.placeHolderProvider = placeHolderProvider
        self.imageProvider = imageProvider
    }
    
    @ViewBuilder
    public var imageView: some View {
        if isShowingPlaceHolder {
            placeHolderProvider()
        } else if let image = self.image {
            imageProvider(image)
        } else {
            placeHolderProvider()
        }
    }
    
    public var body: some View {
        imageView
         .onAppear {
            guard image == nil else {
                return
            }
            donwloadImage(resource: resource)
         }
         .onDisappear(perform: cancelDownload)
         .onChange(of: resource) { resource in
            donwloadImage(resource: resource)
         }
    }
    
    private func cancelDownload() {
        cancellable?.cancel()
    }
    
    private func donwloadImage(resource: AsyncImageResource) {
        cancellable = provider.request(resource: resource) { result in
            switch result {
            case .success(let imageData):
//                print(UIImage.getSequence(imageData: imageData))
                guard let resultImage = UIImage(data: imageData) else {
                    DispatchQueue.main.async {
                        isShowingPlaceHolder = true
                    }
                    return
                }
                DispatchQueue.main.async {
                    image = resultImage
                    isShowingPlaceHolder = false
                }
            case .failure:
                DispatchQueue.main.async {
                    isShowingPlaceHolder = true
                }
            }
        }
    }
}

public struct AsyncImageResource: Resource, Equatable {
    public let baseURL: URL
    public let method: HTTPMethod = .get
    public let path: String
    
    public init(baseURL: URL, path: String) {
        self.baseURL = baseURL
        self.path = path
    }
}

extension UIImage {
static func getSequence(imageData: Data) -> [UIImage]? {

    let gifOptions = [
        kCGImageSourceShouldAllowFloat as String : true as NSNumber,
        kCGImageSourceCreateThumbnailWithTransform as String : true as NSNumber,
        kCGImageSourceCreateThumbnailFromImageAlways as String : true as NSNumber
        ] as CFDictionary

    guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, gifOptions) else {
        debugPrint("Cannot create image source with data!")
        return nil
    }

    let framesCount = CGImageSourceGetCount(imageSource)
    var frameList = [UIImage]()

    for index in 0 ..< framesCount {

        if let cgImageRef = CGImageSourceCreateImageAtIndex(imageSource, index, nil) {
            let uiImageRef = UIImage(cgImage: cgImageRef)
            frameList.append(uiImageRef)
        }

    }

    return frameList // Your gif frames is ready
}
}
