// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GenerateTemplates",
    dependencies: [
        .package(url: "https://github.com/kylef/Commander", from: "0.9.1"),
        .package(url: "https://github.com/JohnSundell/ShellOut", from: "2.3.0")
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "GenerateTemplates",
            dependencies: ["Commander", "ShellOut"]
        ),
        .testTarget(
            name: "GenerateTemplatesTests",
            dependencies: ["GenerateTemplates"]
        ),
    ]
)
