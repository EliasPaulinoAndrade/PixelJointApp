import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.featureProject(
    name: "Root",
    hasResources: false,
    depedencies: [
        .project(target: "DetailingArtInterface", path: "../../Features/DetailingArt"),
        .project(target: "ListingArtsInterface", path: "../../Features/ListingArts"),
        .project(target: "UIToolKit", path: "../../Kits/UIToolKit")
    ]
)
