// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum DetailingArtStrings {
  /// by %@
  public static func by(_ p1: Any) -> String {
    return DetailingArtStrings.tr("DetailingArt", "By", String(describing: p1))
  }

  public enum OnArtDetailExpanded {
    /// Could not load this pixel art
    public static let couldNotLoadArt = DetailingArtStrings.tr("DetailingArt", "OnArtDetailExpanded.CouldNotLoadArt")
    /// Could not load more comments
    public static let couldNotLoadComments = DetailingArtStrings.tr("DetailingArt", "OnArtDetailExpanded.CouldNotLoadComments")
    /// There are no comments
    public static let noComments = DetailingArtStrings.tr("DetailingArt", "OnArtDetailExpanded.NoComments")
    /// There are no more comments
    public static let noMoreComments = DetailingArtStrings.tr("DetailingArt", "OnArtDetailExpanded.NoMoreComments")
    /// See Detail
    public static let seeFullSize = DetailingArtStrings.tr("DetailingArt", "OnArtDetailExpanded.SeeFullSize")
    /// Tap here to retry
    public static let tapToRetry = DetailingArtStrings.tr("DetailingArt", "OnArtDetailExpanded.TapToRetry")
  }

  public enum OnArtDetailMinimized {
    /// Could not load this pixel art
    public static let couldNotLoadArt = DetailingArtStrings.tr("DetailingArt", "OnArtDetailMinimized.CouldNotLoadArt")
    /// Tap here to retry
    public static let tapToRetry = DetailingArtStrings.tr("DetailingArt", "OnArtDetailMinimized.TapToRetry")
  }

  public enum OnImageFullSize {
    /// %@ x
    public static func xTimes(_ p1: Any) -> String {
      return DetailingArtStrings.tr("DetailingArt", "OnImageFullSize.xTimes", String(describing: p1))
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension DetailingArtStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = DetailingArtResources.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
// swiftlint:enable all
// swiftformat:enable all
