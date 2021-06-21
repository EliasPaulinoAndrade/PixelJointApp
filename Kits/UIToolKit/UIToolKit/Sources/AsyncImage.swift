import SwiftUI
import NetworkingKitInterface
import UIKit

public struct AsyncImage<PlaceHolderType: View, ImageType: View>: View {
    public typealias ProviderResult = (data: Data, url: URL)
    
    @State private var image: UIImage?
    @State private var imageData: Data?
    @State private var imageURL: URL?
    @State private var isShowingPlaceHolder = true
    @State private var cancellable: CancellableTask?
    private let provider: AnyProvider<ProviderResult>
    private let resource: AsyncImageResource
    private let placeHolderProvider: () -> PlaceHolderType
    private let imageProvider: (UIImage, Data, URL) -> ImageType
    
    public init(resource: AsyncImageResource,
                provider: AnyProvider<ProviderResult>,
                @ViewBuilder imageProvider: @escaping (UIImage, Data, URL) -> ImageType,
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
        } else if let image = self.image, let data = self.imageData, let imageURL = self.imageURL {
            imageProvider(image, data, imageURL)
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
            case .success(let imageResult):
                guard let resultImage = UIImage(data: imageResult.data) else {
                    DispatchQueue.main.async {
                        isShowingPlaceHolder = true
                    }
                    return
                }
                DispatchQueue.main.async {
                    image = resultImage
                    imageData = imageResult.data
                    imageURL = imageResult.url
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

public extension UIImage {
    static func getSequence(imageData: Data) -> [UIImage] {
        let gifOptions = [
            kCGImageSourceShouldAllowFloat as String: true as NSNumber,
            kCGImageSourceCreateThumbnailWithTransform as String: true as NSNumber,
            kCGImageSourceCreateThumbnailFromImageAlways as String: true as NSNumber
        ] as CFDictionary

        guard let imageSource = CGImageSourceCreateWithData(imageData as CFData, gifOptions) else {
            return []
        }

        let framesCount = CGImageSourceGetCount(imageSource)
        
        let frameList = (0..<framesCount).compactMap { index -> UIImage? in
            guard let cgImageRef = CGImageSourceCreateImageAtIndex(imageSource, index, nil) else {
                return nil
            }
            return UIImage(cgImage: cgImageRef)
        }

        return frameList
    }
    
    class func delayForImageAtIndex(index: Int, source: CGImageSource) -> Double {
        var delay = 0.1

        let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
        let gifProperties: CFDictionary = unsafeBitCast(
            CFDictionaryGetValue(
                cfProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()
            ), to: CFDictionary.self
        )

        var delayObject: AnyObject = unsafeBitCast(
            CFDictionaryGetValue(
                gifProperties,
                Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()
            ), to: AnyObject.self)

        if delayObject.doubleValue == 0 {
            delayObject = unsafeBitCast(
                CFDictionaryGetValue(
                    gifProperties,
                    Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()
                ), to: AnyObject.self
            )
        }

        if let delayObject = delayObject as? Double {
            delay = delayObject
        }
        
        if delay < 0.1 {
            delay = 0.1
        }

        return delay
    }
}
