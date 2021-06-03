import Commander
import Foundation
import ShellOut

let commandsGroup = Group()
commandsGroup.addCommand("Scene", generateSceneCommand())
commandsGroup.addCommand("Feature", generateFeatureCommand())
commandsGroup.addCommand("Kit", generateKitCommand())

commandsGroup.run()
