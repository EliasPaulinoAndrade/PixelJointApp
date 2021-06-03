import ProjectDescription

extension Project {
    public static func defaultProject(projectName: String,
                                      product: Product,
                                      depedencies: [TargetDependency],
                                      lintConfigPath: String = "./../../.swiftlint.yml",
                                      resources: ResourceFileElements? = nil,
                                      extraTargets: [Target] = []) -> Project {
        let testTargetName = "\(projectName)Tests"
        
        return Project(
            name: projectName,
            targets: [
                Target(
                    name: projectName,
                    platform: .iOS,
                    product: product,
                    bundleId: "io.tuist.\(projectName)",
                    infoPlist: "\(projectName)/Info.plist",
                    sources: ["\(projectName)/Sources/**"],
                    resources: resources,
                    actions: [
                        .pre(
                            script: "swiftlint --config \(lintConfigPath)",
                            name: "Swift Lint"
                        )
                    ],
                    dependencies: depedencies
                ),
                Target(
                    name: testTargetName,
                    platform: .iOS,
                    product: .unitTests,
                    bundleId: "io.tuist.\(testTargetName)",
                    infoPlist: "\(testTargetName)/Info.plist",
                    sources: ["\(testTargetName)/Tests/**"],
                    dependencies: [
                        .target(name: projectName)
                    ]
                )
            ] + extraTargets
        )
    }
    
    public static func kitProject(name kitName: String,
                                  depedencies: [TargetDependency] = [],
                                  resources: ResourceFileElements? = nil) -> Project {
        return .defaultProject(
            projectName: kitName,
            product: .framework,
            depedencies: depedencies,
            resources: resources
        )
    }
    
    public static func featureProject(name featureName: String,
                                      depedencies: [TargetDependency] = [],
                                      hasSample: Bool = true,
                                      resources: ResourceFileElements? = nil,
                                      sampleResources: ResourceFileElements? = nil) -> Project {
        let featureSampleName = "\(featureName)Sample"
        let featureDefaultDepedencies: [TargetDependency] = [
            .project(target: "CoreKit", path: "../../Kits/CoreKit"),
        ]
        let featureDepedencies = depedencies + featureDefaultDepedencies
        let featureSampleTarget = Target(
            name: featureSampleName,
            platform: .iOS,
            product: .app,
            bundleId: "io.tuist.\(featureSampleName)",
            infoPlist: "\(featureSampleName)/Info.plist",
            sources: ["\(featureSampleName)/Sources/**"],
            resources: sampleResources,
            dependencies: [ .target(name: featureName)]  + featureDepedencies
        )
        
        let extraTargets = hasSample ? [featureSampleTarget] : []
        
        return .defaultProject(
            projectName: featureName,
            product: .framework,
            depedencies: featureDepedencies,
            resources: resources,
            extraTargets: extraTargets
        )
    }
}
