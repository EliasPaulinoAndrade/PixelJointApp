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
        .defaultProject(
            projectName: kitName,
            product: .framework,
            depedencies: depedencies,
            resources: resources
        )
    }
    
    public static func featureProject(name featureName: String,
                                      hasResources: Bool,
                                      depedencies: [TargetDependency] = [],
                                      hasSample: Bool = true,
                                      hasInterface: Bool = false,
                                      extraTargets: [Target] = []) -> Project {
        let featureDepedencies = depedencies + featureDefaultDepedencies()
        let interfaceTarget = interfaceTarget(featureName: featureName)
        let interfaceDepedency = TargetDependency.target(name: interfaceTarget.name)
        let featureInterfaceDepedency = hasInterface ? [interfaceDepedency] : []
        let sampleTarget = sampleTarget(
            featureName: featureName,
            featureDepedencies: featureDepedencies + featureInterfaceDepedency
        )
        let sampleTargetArray = hasSample ? [sampleTarget] : []
        let interfaceTargetArray = hasInterface ? [interfaceTarget] : []
        let featureResources: ResourceFileElements? = hasResources ? ["\(featureName)/Resources/**/*"] : []
        
        return .defaultProject(
            projectName: featureName,
            product: .framework,
            depedencies: featureDepedencies + featureInterfaceDepedency,
            resources: featureResources,
            extraTargets: sampleTargetArray + interfaceTargetArray + extraTargets
        )
    }
    
    private static func featureDefaultDepedencies() -> [TargetDependency] {
        [
            .project(target: "CoreKit", path: "../../Kits/CoreKit")
        ]
    }
    
    private static func interfaceTarget(featureName: String) -> Target {
        let featureInterfaceName = "\(featureName)Interface"
        
        return Target(
            name: featureInterfaceName,
            platform: .iOS,
            product: .framework,
            bundleId: "io.tuist.\(featureInterfaceName)",
            infoPlist: "\(featureInterfaceName)/Info.plist",
            sources: ["\(featureInterfaceName)/Sources/**"],
            dependencies: featureDefaultDepedencies()
        )
    }

    private static func sampleTarget(featureName: String,
                                     featureDepedencies: [TargetDependency]) -> Target {
        let featureSampleName = "\(featureName)Sample"
        
        return Target(
            name: featureSampleName,
            platform: .iOS,
            product: .app,
            bundleId: "io.tuist.\(featureSampleName)",
            infoPlist: "\(featureSampleName)/Info.plist",
            sources: ["\(featureSampleName)/Sources/**"],
            resources: ["\(featureSampleName)/Resources/**/*"],
            dependencies: [ .target(name: featureName) ]  + featureDepedencies
        )
    }
}
