define ["backboneapp", "./views/typeareaview"], (BackboneApp, TypeAreaView) ->
  'use strict'

  class MainApp extends BackboneApp
    
    constructor: ->
      super
      new TypeAreaView()
