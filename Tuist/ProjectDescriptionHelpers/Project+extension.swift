import ProjectDescription

extension Project {
    private static func defaultDeploymentTarget() -> DeploymentTarget {
        .iOS(targetVersion: "14.0", devices: [.ipad, .iphone])
    }

    public static func defaultProject(projectName: String,
                                      product: Product,
                                      depedencies: [TargetDependency],
                                      packages: [Package] = [],
                                      testExtraDepedencies: [TargetDependency] = [],
                                      additionalFiles: [FileElement] = [],
                                      lintConfigPath: String = "./../../.swiftlint.yml",
                                      resources: ResourceFileElements? = nil,
                                      extraTargets: [Target] = [],
                                      testActions: [TargetAction] = []) -> Project {
        let testTargetName = "\(projectName)Tests"
        
        let swiftLintAction = TargetAction.pre(
            script: "swiftlint --config \(lintConfigPath)",
            name: "Swift Lint"
        )
        
        return Project(
            name: projectName,
            packages: packages,
            targets: [
                Target(
                    name: projectName,
                    platform: .iOS,
                    product: product,
                    bundleId: "io.tuist.\(projectName)",
                    deploymentTarget: defaultDeploymentTarget(),
                    infoPlist: "\(projectName)/Info.plist",
                    sources: ["\(projectName)/Sources/**"],
                    resources: resources,
                    actions: [swiftLintAction],
                    dependencies: depedencies
                ),
                Target(
                    name: testTargetName,
                    platform: .iOS,
                    product: .unitTests,
                    bundleId: "io.tuist.\(testTargetName)",
                    deploymentTarget: defaultDeploymentTarget(),
                    infoPlist: "\(testTargetName)/Info.plist",
                    sources: ["\(testTargetName)/Tests/**"],
                    actions: testActions,
                    dependencies: [
                        .target(name: projectName),
                    ] + testExtraDepedencies
                )
            ] + extraTargets,
            additionalFiles: additionalFiles
        )
    }
    
    public static func kitProject(name kitName: String,
                                  hasInterface: Bool = false,
                                  depedencies: [TargetDependency] = [],
                                  packages: [Package] = [],
                                  additionalFiles: [FileElement] = [],
                                  hasResources: Bool = false) -> Project {
        let interfaceTarget = interfaceTarget(featureName: kitName)
        let interfaceDepedency = TargetDependency.target(name: interfaceTarget.name)
        let interfaceTargetArray = hasInterface ? [interfaceTarget] : []
        let featureInterfaceDepedency = hasInterface ? [interfaceDepedency] : []
        let sourceryTestAction = TargetAction.pre(
            script: "sourcery --sources . --templates ./../../Tuist/Templates/StencilTemplates/Doubles.stencil --output ./\(kitName)Tests/Tests/Generated --args moduleName=\(kitName)",
            name: "Sourcery"
        )
        let kitResources: ResourceFileElements? = hasResources ? ["\(kitName)/Resources/**/*"] : []
        
        return .defaultProject(
            projectName: kitName,
            product: .framework,
            depedencies: depedencies + featureInterfaceDepedency,
            packages: packages,
            testExtraDepedencies: [.project(target: "TestKit", path: "./../../Kits/TestKit")],
            additionalFiles: additionalFiles,
            resources: kitResources,
            extraTargets: interfaceTargetArray,
            testActions: [sourceryTestAction]
        )
    }
    
    public static func featureProject(name featureName: String,
                                      hasResources: Bool,
                                      depedencies: [TargetDependency] = [],
                                      packages: [Package] = [],
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
        let sourceryTestAction = TargetAction.pre(
            script: "sourcery --sources . --templates ./../../Tuist/Templates/StencilTemplates/Doubles.stencil --output ./\(featureName)Tests/Tests/Generated --args moduleName=\(featureName)",
            name: "Sourcery"
        )
        
        return .defaultProject(
            projectName: featureName,
            product: .framework,
            depedencies: featureDepedencies + featureInterfaceDepedency,
            packages: packages,
            testExtraDepedencies: [.project(target: "TestKit", path: "./../../Kits/TestKit")],
            resources: featureResources,
            extraTargets: sampleTargetArray + interfaceTargetArray + extraTargets,
            testActions: [sourceryTestAction]
        )
    }
    
    private static func featureDefaultDepedencies() -> [TargetDependency] {
        [
            .project(target: "CoreKit", path: "../../Kits/CoreKit")
        ]
    }
    
    private static func interfaceTarget(featureName: String) -> Target {
        let interfaceName = "\(featureName)Interface"
        
        return Target(
            name: interfaceName,
            platform: .iOS,
            product: .framework,
            bundleId: "io.tuist.\(interfaceName)",
            deploymentTarget: defaultDeploymentTarget(),
            infoPlist: "\(interfaceName)/Info.plist",
            sources: ["\(interfaceName)/Sources/**"],
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
            deploymentTarget: defaultDeploymentTarget(),
            infoPlist: "\(featureSampleName)/Info.plist",
            sources: ["\(featureSampleName)/Sources/**"],
            resources: ["\(featureSampleName)/Resources/**/*"],
            dependencies: [ .target(name: featureName) ]  + featureDepedencies
        )
    }
}
