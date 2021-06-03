scene:
	@swift run GenerateTemplates --package-path Scripts/GenerateTemplates Scene $(feature) $(scene) --hasView $(or $(hasView), True) --hasPresenter $(or $(hasPresenter), True) --hasListener $(or $(hasListener), False)
feature:
	@swift run GenerateTemplates --package-path Scripts/GenerateTemplates Feature $(name)
kit:
	@swift run GenerateTemplates --package-path Scripts/GenerateTemplates Kit $(name)
