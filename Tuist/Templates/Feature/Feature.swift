import ProjectDescription
import ProjectDescriptionHelpers

let featureName = Template.Attribute.required("name")

let feature: Template = {
    let featureTargetFiles: [Template.File] = [
        .file(
            path: "./Features/\(featureName)/\(featureName)/Info.plist",
            templatePath: "../StencilTemplates/Plists/FrameworkPlist.stencil"
        ),
        .file(
            path: "./Features/\(featureName)/Project.swift",
            templatePath: "../StencilTemplates/FeatureProject.stencil"
        ),
        .file(
            path: "./Features/\(featureName)/\(featureName)/Sources/Flow/\(featureName)Builder.swift",
            templatePath: "../StencilTemplates/FeatureBuilder.stencil"
        )
    ]

    let testsTargetFiles: [Template.File] = [
        .file(
            path: "./Features/\(featureName)/\(featureName)Tests/Info.plist",
            templatePath: "../StencilTemplates/Plists/TestAppPlist.stencil"
        ),
        .file(
            path: "./Features/\(featureName)/\(featureName)Tests/Tests/\(featureName)Tests.swift",
            templatePath: "../StencilTemplates/FeatureTests.stencil"
        )
    ]
    
    let sampleTargetFiles: [Template.File] = [
        .file(
            path: "./Features/\(featureName)/\(featureName)Sample/Sources/AppDelegate.swift",
            templatePath: "../StencilTemplates/AppDelegate.stencil"
        ),
        .file(
            path: "./Features/\(featureName)/\(featureName)Sample/Info.plist",
            templatePath: "../StencilTemplates/Plists/IOSAppPlist.stencil"
        ),
        .file(
            path: "./Features/\(featureName)/\(featureName)Sample/Sources/ViewController.swift",
            templatePath: "../StencilTemplates/SampleViewController.stencil"
        ),
        .file(
            path: "./Features/\(featureName)/\(featureName)Sample/Resources/Base.lproj/LaunchScreen.storyboard",
            templatePath: "../StencilTemplates//LaunchScreen.stencil"
        )
    ]
    
    return Template(
        description: "Feature",
        attributes: [featureName],
        files: featureTargetFiles + testsTargetFiles + sampleTargetFiles
    )    
}()
