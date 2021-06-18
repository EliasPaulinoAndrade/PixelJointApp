import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.featureProject(
    name: "ListingArts",
    hasResources: true,
    depedencies: [
        .project(target: "NetworkingKitInterface", path: "../../Kits/NetworkingKit"),
        .project(target: "WebScrapingKitInterface", path: "../../Kits/WebScrapingKit"),
        .project(target: "UIToolKit", path: "../../Kits/UIToolKit")
    ],
    hasInterface: true
)

