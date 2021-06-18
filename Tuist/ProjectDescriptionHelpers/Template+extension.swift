import ProjectDescription

extension Template {
    public static func sceneTemplate(_ entityNames: [String]) -> Template {
        let nameAttribute: Template.Attribute = .required("name")
        let featureAttribute: Template.Attribute = .required("feature")
        
        let templateFiles = makeTemplateFiles(
            entityNames: entityNames,
            featureAttribute: featureAttribute,
            nameAttribute: nameAttribute
        )
        
        let templateTestFiles = makeTestTemplateFiles(
            entityNames: entityNames,
            featureAttribute: featureAttribute,
            nameAttribute: nameAttribute
        )

        return Template(
            description: "Scene",
            attributes: [
                nameAttribute,
                featureAttribute,
                .optional("hasView", default: "True"),
                .optional("hasPresenter", default: "True"),
                .optional("hasListener", default: "False")
            ],
            files: templateFiles + templateTestFiles
        )
    }
    
    private static func makeTestTemplateFiles(entityNames: [String],
                                              featureAttribute: Template.Attribute,
                                              nameAttribute: Template.Attribute) -> [Template.File] {
        entityNames
            .filter { entityName in
                entityName != "ViewController" && entityName != "Builder"
            }
            .map { entityName in
                .file(
                    path: "./Features/\(featureAttribute)/\(featureAttribute)Tests/Tests/Scenes/\(nameAttribute)/\(nameAttribute)\(entityName)Tests.swift",
                    templatePath: "../StencilTemplates/EntitiesTests/\(entityName)Tests.stencil"
                )
            }
    }
    
    private static func makeTemplateFiles(entityNames: [String],
                                          featureAttribute: Template.Attribute,
                                          nameAttribute: Template.Attribute) -> [Template.File] {
        entityNames.map { entityName in
            .file(
                path: "./Features/\(featureAttribute)/\(featureAttribute)/Sources/Scenes/\(nameAttribute)/\(nameAttribute)\(entityName).swift",
                templatePath: "../StencilTemplates/Entities/\(entityName).stencil"
            )
        }
    }
}
