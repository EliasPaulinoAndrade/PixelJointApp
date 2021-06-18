import ProjectDescription

let kitName = Template.Attribute.required("name")

let kit: Template = {
    let featureTargetFiles: [Template.File] = [
        .file(
            path: "./Kits/\(kitName)/\(kitName)/Info.plist",
            templatePath: "../StencilTemplates/Plists/FrameworkPlist.stencil"
        ),
        .file(
            path: "./Kits/\(kitName)/Project.swift",
            templatePath: "../StencilTemplates/KitProject.stencil"
        ),
        .string(
            path: "./Kits/\(kitName)/\(kitName)/Sources/EmptyModule.swift",
            contents: "// Your Kit Was Created"
        )
    ]

    let testsTargetFiles: [Template.File] = [
        .file(
            path: "./Kits/\(kitName)/\(kitName)Tests/Info.plist",
            templatePath: "../StencilTemplates/Plists/TestAppPlist.stencil"
        ),
        .file(
            path: "./Kits/\(kitName)/\(kitName)Tests/Tests/\(kitName)Tests.swift",
            templatePath: "../StencilTemplates/FeatureTests.stencil"
        ),
        .string(
            path: "./Kits/\(kitName)/\(kitName)Tests/Tests/Generated/Doubles.generated.swift",
            contents: "// Empty File"
        )
    ]
    
    return Template(
        description: "Kit",
        attributes: [kitName],
        files: featureTargetFiles + testsTargetFiles
    )
}()
