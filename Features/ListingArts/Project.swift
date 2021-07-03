import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.featureProject(
    name: "ListingArts",
    hasResources: true,
    depedencies: [
        .project(target: "NetworkingKitInterface", path: "../../Kits/NetworkingKit"),
        .project(target: "WebScrapingKitInterface", path: "../../Kits/WebScrapingKit"),
        .project(target: "UIToolKit", path: "../../Kits/UIToolKit"),
        .cocoapods(path: "./../../.")
    ],
    hasInterface: true,
    sampleDepedencies: [
        .project(target: "NetworkingKit", path: "../../Kits/NetworkingKit"),
        .project(target: "WebScrapingKit", path: "../../Kits/WebScrapingKit")
    ]
)

