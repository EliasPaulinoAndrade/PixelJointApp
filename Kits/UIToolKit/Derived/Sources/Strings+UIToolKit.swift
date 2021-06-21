// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum UIToolKitStrings {
  /// \n<html>\n    <head>\n        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">\n        <style>\n            * {\n                word-wrap: break-word;\n                font-family: %@;\n                font-size: %@;\n                color: rgb(%@, %@, %@) !important;\n                margin: 0;\n                padding: 0;\n            }\n\n            a {\n                color: rgb(%@, %@, %@) !important;\n            }\n        </style>\n    </head>\n    <body>\n        %@\n    </body>\n</html>
  public static func html(_ p1: Any, _ p2: Any, _ p3: Any, _ p4: Any, _ p5: Any, _ p6: Any, _ p7: Any, _ p8: Any, _ p9: Any) -> String {
    return UIToolKitStrings.tr("WebView", "HTML", String(describing: p1), String(describing: p2), String(describing: p3), String(describing: p4), String(describing: p5), String(describing: p6), String(describing: p7), String(describing: p8), String(describing: p9))
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension UIToolKitStrings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = UIToolKitResources.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
// swiftlint:enable all
// swiftformat:enable all
