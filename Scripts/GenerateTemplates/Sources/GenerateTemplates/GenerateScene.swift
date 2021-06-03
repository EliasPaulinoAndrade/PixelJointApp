import Foundation
import Commander
import ShellOut

private func generateSceneTemplates(feature: String,
                               scene: String,
                               hasView: Bool,
                               hasPresenter: Bool,
                               hasListener: Bool) {
    let scaffoldCommand: String
    
    switch (hasView, hasPresenter) {
    case (true, false):
        print("\n🎨 Creating a little visible scene that don't need a Presenter")
        scaffoldCommand = "SceneWithoutPresenter"
    case (false, _):
        print("\n🧠 Creating a pure logical scene, without view layer")
        scaffoldCommand = "SceneWithoutView"
    default:
        print("\n🎨 Creating a visible scene with Presenter\n")
        scaffoldCommand = "Scene"
    }
    
    let generateTemplateCommand = "tuist scaffold " + scaffoldCommand +
        " --name \(scene)" +
        " --feature \(feature)" +
        " --has-view \(String(hasView).capitalized)" +
        " --has-presenter \(String(hasPresenter).capitalized)" +
        " --has-listener \(String(hasListener).capitalized)"
    
    let generateProjectCommand = "tuist generate --path Features/\(feature)/ --project-only"
    
    do {
        try shellOut(to: generateTemplateCommand + "\n" + generateProjectCommand)
        
        print("✅ Created Scene")
        print("✅ Re-Generated Feature \(feature)")
    } catch {
        print(error)
    }
}

public func generateSceneCommand() -> CommandType {
    command(
        Argument<String>("feature"),
        Argument<String>("scene"),
        Option<Bool>("hasView", default: true),
        Option<Bool>("hasPresenter", default: true),
        Option<Bool>("hasListener", default: false),
        generateSceneTemplates
    )
}
