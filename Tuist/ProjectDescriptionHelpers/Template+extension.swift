import ProjectDescription

extension Template {
    public static func sceneTemplate(_ entityNames: [String]) -> Template {
        let nameAttribute: Template.Attribute = .required("name")
        let featureAttribute: Template.Attribute = .required("feature")

        return Template(
            description: "Scene",
            attributes: [
                nameAttribute,
                featureAttribute,
                .optional("hasView", default: "True"),
                .optional("hasPresenter", default: "True"),
                .optional("hasListener", default: "False")
            ],
            files: makeTemplateFiles(
                entityNames: entityNames,
                featureAttribute: featureAttribute,
                nameAttribute: nameAttribute
            )
        )
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
