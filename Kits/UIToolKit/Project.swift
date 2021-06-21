import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.kitProject(
    name: "UIToolKit",
    depedencies: [
        .project(target: "NetworkingKitInterface", path: "../NetworkingKit")
    ],
    hasResources: true
)
