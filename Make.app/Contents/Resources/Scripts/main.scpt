JsOsaDAS1.001.00bplist00�Vscript_iconst SceneOption = {
	withView: "include View Layer",
	withListener: "include Scene Listener",
	withPresenter: "include Presenter"
}

const UserOption = {
	createScene: "Create Scene",
	createFeature: "Create Feature",
	createKit: "Create Kit"
}

function capitalize(string) {
  	return string.charAt(0).toUpperCase() + string.slice(1)
}

function getCurrentPathComponents(app) {
	const currentPath = app.pathTo(this).toString()
	const pathComponents = currentPath.toString().split('/')
	return pathComponents.slice(0, -1);
}

function getCurrentPath(app) {
	const currentFolderComponents = getCurrentPathComponents(app)
	return currentFolderComponents.join("/")
}

function getFeaturesPath(app) {
	const currentFolderComponents = getCurrentPathComponents(app)	
	return currentFolderComponents.concat(["Features"]).join("/")
}

function doShellScriptInAppFolder(app, shellCommand) {
	const projectPath = getCurrentPath(app)
	const exportPathCommand = "export PATH=$PATH:/usr/local/bin"
	const openFolderCommand = `cd ${projectPath}`
	const baseCommand = exportPathCommand + ";" + openFolderCommand
	app.doShellScript(baseCommand + ";" + shellCommand)
}

function sceneTemplateSteps(app, parentFeatureName, sceneName, sceneOptions) {
	return [
		{
			description: `Generating ${sceneName} scene at ${parentFeatureName} feature`,
			command: () => {
				const hasListener = sceneOptions.includes(SceneOption.withListener)
				const hasView = sceneOptions.includes(SceneOption.withView)
				const hasPresenter = sceneOptions.includes(SceneOption.withPresenter)
				const sceneType = function () {
					if (hasView && !hasPresenter) {
						return "SceneWithoutPresenter"
					}
					if (!hasView) {
						return "SceneWithoutView"
					} 				
					return "Scene"
				}()
				const scaffoldSceneCommand = `tuist scaffold ${sceneType} ` + 
					`--name ${sceneName} ` + 
					`--feature ${parentFeatureName} ` + 
					`--has-view ${capitalize(hasView.toString())} ` +
					`--has-presenter ${capitalize(hasPresenter.toString())} ` +
					`--has-listener ${capitalize(hasListener.toString())} ` 
				doShellScriptInAppFolder(app, scaffoldSceneCommand)
			}
		},
		{
			description: `Re-Generating ${parentFeatureName} feature project`,
			command: () => {
				const generateProjectCommand = `tuist generate --path Features/${parentFeatureName} --project-only`
				doShellScriptInAppFolder(app, generateProjectCommand)
			}
		}
	]
}

function featureOrKitTemplateSteps(app, name, isFeature) {
	return [
		{
			description: "Closing XCode",
			command: () => {
				const xcode = Application('Xcode');
				xcode.quit()
			}
		},
		{
			description: `Adding ${name} Files`,
			command: () => {
				const templateName = isFeature ? "Feature" : "Kit"
				const scaffoldFeatureCommand = `tuist scaffold ${templateName} --name ${name}`
				doShellScriptInAppFolder(app, scaffoldFeatureCommand)
			}
		},
		{
			description: "Re-Generating Workspace",
			command: () => {
				const generateProjectCommand = "tuist generate"
				doShellScriptInAppFolder(app, generateProjectCommand)
			}
		}, 
		{
			description: "Openning XCode",
			command: () => {
				const openXCodeCommand = "open *.xcworkspace"
				doShellScriptInAppFolder(app, openXCodeCommand)			
			}
		}
	]
}

function executeCommandSteps(steps, title) {
	Progress.totalUnitCount = steps.length
	Progress.description = title
	
	for (var stepIndex = 0, step = steps[0]; stepIndex < steps.length; stepIndex ++, step = steps[stepIndex]) { 
		Progress.completedUnitCount = stepIndex
		Progress.additionalDescription = step.description
		step.command()	
	}
	
	Progress.completedUnitCount = steps.length
	Progress.additionalDescription = "Done!"
}

function createKit(app) {
	const kitName = askUserInput(app, "Kit Name: ", "Create Kit")
	const templateSteps = featureOrKitTemplateSteps(app, kitName, false)
	executeCommandSteps(templateSteps, `Creating Kit ${kitName}`)
}

function createFeature(app) {
	const featureName = askUserInput(app, "Feature Name: ", "Create Feature")
	const templateSteps = featureOrKitTemplateSteps(app, featureName, true)
	executeCommandSteps(templateSteps, `Creating Feature ${featureName}`)
}

function createScene(app) {
	const parentFeatureName = askParentFeatureName(app)
	const sceneName = askUserInput(app, "SceneName: ", "Create Scene")
	const sceneOptions = askSceneOptions(app)
	const templateSteps = sceneTemplateSteps(app, parentFeatureName, sceneName, sceneOptions)
	executeCommandSteps(templateSteps, `Creating Scene ${sceneName}`)
}

function askSceneOptions(app) {
	const sceneOptions = [SceneOption.withView, SceneOption.withListener, SceneOption.withPresenter]
	
	const selectedOption = app.chooseFromList(sceneOptions, {
		withTitle: "Create Scene",
    	withPrompt: "Select the scene options: ",
		multipleSelectionsAllowed: true,
		emptySelectionAllowed: true,
		defaultItems: [SceneOption.withView, SceneOption.withPresenter]
	})
	
	if (!selectedOption) {
		app.quit()
	}
	
	return selectedOption
}

function askParentFeatureName(app) {
	const systemEvents = Application('System Events')
	const featuresPath = getFeaturesPath(app)
	const featureFolders = systemEvents
		.folders
		.byName(featuresPath)
		.diskItems.name()
		.filter(folder => { 
			return !folder.includes(".") 
		})
					
	const selectedOption = app.chooseFromList(featureFolders, {
		withTitle: "Create Scene",
    	withPrompt: "Select the parent feature:"
	})
	
	if (!selectedOption) {
		app.quit()
	}
	
	return selectedOption
}

function askUserInput(app, title, windowTitle) {
	const response = app.displayDialog(title, {
		withTitle: windowTitle,
    	defaultAnswer: "",
    	withIcon: "note",
    	buttons: ["Cancel", "Continue"],
    	defaultButton: "Continue",
		cancelButton: "Cancel"
	})

	const featureName = response.textReturned.trim()
	
	if (featureName.length === 0) {
		throw new Error("Invalid Input");
	}
	
	return capitalize(featureName)
}

function askUserOption(app) {
	const options = [UserOption.createScene, UserOption.createFeature, UserOption.createKit]
	const selectedOption = app.chooseFromList(options, { 
		withTitle: "Code Generator",
		withPrompt: "Select an Option: "
	})
	
	if (selectedOption == UserOption.createScene) {
		return createScene(app)
	}
	
	if (selectedOption == UserOption.createFeature) {
		return createFeature(app)
	}
	
	if (selectedOption == UserOption.createKit) { 
		return createKit(app)
	}
}

app = Application.currentApplication()
app.includeStandardAdditions = true

askUserOption(app)
                               jscr  ��ޭ