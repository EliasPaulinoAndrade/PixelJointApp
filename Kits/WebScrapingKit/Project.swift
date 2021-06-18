import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.kitProject(
    name: "WebScrapingKit",
    hasInterface: true,
    depedencies: [
        .package(product: "SwiftSoup"),
        .project(target: "NetworkingKitInterface", path: "../NetworkingKit")
    ],
    packages: [
        .remote(url: "https://github.com/scinfu/SwiftSoup.git", requirement: .exact("2.3.2"))
    ]
)
