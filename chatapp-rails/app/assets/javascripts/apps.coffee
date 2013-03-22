define ['jquery', 'apps/main/main'], ($, MainApp) ->
  'use strict'

  autoInit:
    '#chat-page': MainApp

  register: ->
    @initializeWidgets(document.body)

  initializeWidgets: (nodes) ->
    $nodes = $(nodes)

    for selector, constructorName of @autoInit
      for el in $nodes.find(selector).add($nodes.filter(selector))
        constructorName.initialize()
        return null