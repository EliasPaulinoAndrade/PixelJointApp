import ProjectDescription
import ProjectDescriptionHelpers

//let project = Project(
//    name: "CoreKit",
//    targets: [
//        Target(
//            name: "CoreKit",
//            platform: .iOS,
//            product: .framework,
//            bundleId: "io.tuist.CoreKit",
//            infoPlist: "CoreKit/Info.plist",
//            sources: ["CoreKit/Sources/**"]
//        ),
//        Target(
//            name: "CoreKitTests",
//            platform: .iOS,
//            product: .unitTests,
//            bundleId: "io.tuist.CoreKitTests",
//            infoPlist: "CoreKitTests/Info.plist",
//            sources: ["CoreKitTests/Tests/**"],
//            dependencies: [
//                .target(name: "CoreKit")
//            ]
//        )
//    ]
//)

let project = Project.kitProject(
    name: "CoreKit",
    depedencies: [
        .cocoapods(path: "./../../.")
    ]
)
