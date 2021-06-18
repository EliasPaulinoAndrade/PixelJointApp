import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.kitProject(
    name: "TestKit",
    depedencies: [.project(target: "CoreKit", path: "./../CoreKit")]
)
