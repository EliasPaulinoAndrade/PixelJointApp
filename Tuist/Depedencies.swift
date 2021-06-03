import ProjectDescription

let dependencies = Dependencies(
    carthage: .carthage(
        [
            .github(path: "Alamofire/Alamofire", requirement: .exact("5.0.4"))
        ],
        options: [.useXCFrameworks, .noUseBinaries]
    ),
    swiftPackageManager: nil, // work in progress, pass `nil`
    platforms: [.iOS]
)
