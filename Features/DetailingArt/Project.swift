import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.featureProject(
    name: "DetailingArt",
    hasResources: true,
    depedencies: [
        .project(target: "NetworkingKitInterface", path: "../../Kits/NetworkingKit"),
        .project(target: "WebScrapingKitInterface", path: "../../Kits/WebScrapingKit"),
        .project(target: "UIToolKit", path: "../../Kits/UIToolKit"),
        .cocoapods(path: "./../../.")
    ],
//    packages: [
//        .remote(
//            url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git",
//            requirement: .exact("2.0.2")
//        )
//    ],
    hasInterface: true
)
