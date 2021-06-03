import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.defaultProject(
    projectName: "Tidie",
    product: .app,
    depedencies: [
        .project(target: "Lucha", path: "../Features/Lucha"),
        .project(target: "Bugiganga", path: "../Features/Bugiganga")
    ],
    lintConfigPath: "./../.swiftlint.yml",
    resources: ["Tidie/Resources/**"]
)
