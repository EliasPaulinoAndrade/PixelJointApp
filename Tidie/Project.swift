import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.defaultProject(
    projectName: "Tidie",
    product: .app,
    depedencies: [
        .project(target: "Lucha", path: "../Features/Lucha"),
        .project(target: "Bugiganga", path: "../Features/Bugiganga"),
        .project(target: "Pucca", path: "../Features/Pucca")
    ],
    lintConfigPath: "./../.swiftlint.yml",
    resources: ["Tidie/Resources/**"]
)
