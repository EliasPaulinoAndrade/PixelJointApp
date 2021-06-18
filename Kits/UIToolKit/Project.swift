import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.kitProject(
    name: "UIToolKit",
    depedencies: [
        .project(target: "NetworkingKitInterface", path: "../NetworkingKit"),
        .package(product: "SDWebImageSwiftUI")
    ],
    packages: [
        .remote(
            url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git",
            requirement: .exact("2.0.0")
        )
    ],
    hasResources: true
)
