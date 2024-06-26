// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum ListingArtsStrings {

  public enum OnArtsList {
    /// Could not load the arts
    public static let couldNotLoad = ListingArtsStrings.tr("ListingArts", "OnArtsList.CouldNotLoad")
    /// Could not load more arts
    public static let couldNotLoadMore = ListingArtsStrings.tr("ListingArts", "OnArtsList.CouldNotLoadMore")
    /// Listing Arts
    public static let listingArts = ListingArtsStrings.tr("ListingArts", "OnArtsList.ListingArts")
    /// There are no more arts
    public static let noMoreArts = ListingArtsStrings.tr("ListingArts", "OnArtsList.NoMoreArts")
    /// Tap here to retry
    public static let tapToRetry = ListingArtsStrings.tr("ListingArts", "OnArtsList.TapToRetry")
  }

  public enum OnSectionsList {
    /// Close
    public static let close = ListingArtsStrings.tr("ListingArts", "OnSectionsList.Close")
    /// Highest Rating
    public static let highestRating = ListingArtsStrings.tr("ListingArts", "OnSectionsList.HighestRating")
    /// Most Favorites
    public static let mostFavorites = ListingArtsStrings.tr("ListingArts", "OnSectionsList.MostFavorites")
    /// Newest
    public static let newest = ListingArtsStrings.tr("ListingArts", "OnSectionsList.Newest")
    /// Pixel Joint
    public static let pixelJoint = ListingArtsStrings.tr("ListingArts", "OnSectionsList.PixelJoint")
    /// Please choose a section
    public static let pleaseChooseSection = ListingArtsStrings.tr("ListingArts", "OnSectionsList.PleaseChooseSection")
    /// Section Selection
    public static let sectionSelection = ListingArtsStrings.tr("ListingArts", "OnSectionsList.SectionSelection")
    /// Weekly Showcase
    public static let weeklyShowcase = ListingArtsStrings.tr("ListingArts", "OnSectionsList.WeeklyShowcase")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension ListingArtsStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = ListingArtsResources.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
// swiftlint:enable all
// swiftformat:enable all
