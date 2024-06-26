// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum UIToolKitAsset {
  public enum Assets {
    public static let background = UIToolKitColors(name: "Background")
    public static let darkBackgroundLegacy = UIToolKitColors(name: "DarkBackgroundLegacy")
    public static let extraDark = UIToolKitColors(name: "ExtraDark")
    public static let link = UIToolKitColors(name: "Link")
    public static let text = UIToolKitColors(name: "Text")
    public static let networkingErrorIcon = UIToolKitImages(name: "networkingErrorIcon")
  }
  public enum Colors {
    public static let action1 = UIToolKitColors(name: "Action1")
    public static let background1 = UIToolKitColors(name: "Background1")
    public static let background2 = UIToolKitColors(name: "Background2")
    public static let background3 = UIToolKitColors(name: "Background3")
    public static let background4 = UIToolKitColors(name: "Background4")
    public static let darkBackground = UIToolKitColors(name: "DarkBackground")
    public static let text1 = UIToolKitColors(name: "Text1")
    public static let text2 = UIToolKitColors(name: "Text2")
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class UIToolKitColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension UIToolKitColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: UIToolKitColors) {
    let bundle = UIToolKitResources.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

public struct UIToolKitImages {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = UIToolKitResources.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
}

public extension UIToolKitImages.Image {
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the UIToolKitImages.image property")
  convenience init?(asset: UIToolKitImages) {
    #if os(iOS) || os(tvOS)
    let bundle = UIToolKitResources.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:enable all
// swiftformat:enable all
