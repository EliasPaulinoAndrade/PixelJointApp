import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.featureProject(
    name: "Lucha",
    hasResources: true,
    depedencies: [
        .project(target: "PuccaInterface", path: "../Pucca")
    ]
)
