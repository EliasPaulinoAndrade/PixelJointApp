import Foundation
import Commander
import ShellOut

private func generateKitTemplates(feature: String) {
    do {
        print("\n🛠 Creating \(feature) Files \n")
        
        try shellOut(to: "KillAll Xcode")
        try shellOut(to: "tuist scaffold Kit --name \(feature)")
        try shellOut(to: "tuist generate")
        try shellOut(to: "open TidieApp.xcworkspace")
        
        print("✅ Created Kit")
        print("✅ Re-Generated TidieApp")
    } catch {
        print(error)
    }
}

public func generateKitCommand() -> CommandType {
    command(
        Argument<String>("kit"),
        generateKitTemplates
    )
}
