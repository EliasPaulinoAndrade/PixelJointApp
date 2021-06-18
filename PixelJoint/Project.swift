import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.defaultProject(
    projectName: "PixelJoint",
    product: .app,
    depedencies: [
        .project(target: "CoreKit", path: "../Kits/CoreKit"),
        .project(target: "NetworkingKit", path: "../Kits/NetworkingKit"),
        .project(target: "WebScrapingKit", path: "../Kits/WebScrapingKit"),
        .project(target: "NetworkingKitInterface", path: "../Kits/NetworkingKit"),
        .project(target: "WebScrapingKitInterface", path: "../Kits/WebScrapingKit"),
        .project(target: "ListingArts", path: "../Features/ListingArts"),
        .project(target: "DetailingArt", path: "../Features/DetailingArt"),
        .project(target: "DetailingArtInterface", path: "../Features/DetailingArt"),
        .project(target: "Root", path: "../Features/Root")
    ],
    additionalFiles: ["PJPlayground.playground"],
    lintConfigPath: "./../.swiftlint.yml",
    resources: ["PixelJoint/Resources/**"]
)
