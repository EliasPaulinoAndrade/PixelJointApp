import Foundation
import Commander
import ShellOut

private func generateFeatureTemplates(feature: String) {
    do {
        print("\n🛠 Creating \(feature) Files \n")
        
        try shellOut(to: "KillAll Xcode")
        try shellOut(to: "tuist scaffold Feature --name \(feature)")
        try shellOut(to: "tuist generate")
        try shellOut(to: "open TidieApp.xcworkspace")
        
        print("✅ Created Feature")
        print("✅ Re-Generated TidieApp")
    } catch {
        print(error)
    }
}

public func generateFeatureCommand() -> CommandType {
    command(
        Argument<String>("feature"),
        generateFeatureTemplates
    )
}
