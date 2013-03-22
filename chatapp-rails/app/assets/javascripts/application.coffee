require.config
  
  shim:
    underscore:
      exports: "_"

    backbone:
      deps: ["underscore", "jquery"]
      exports: "Backbone"

    rails:
      deps: ["jquery"]
      exports: "rails"

    handlebars:
      exports: "Handlebars"

    io:
      exports: "io"

    socketapp:
      deps: ["io"]
      exports: "SocketApp"

  paths:
    underscore: "lib/lodash/lodash.min"
    backbone:   "lib/backbone/backbone"
    text:       "lib/require/text"
    rails:      "lib/rails/rails"
    handlebars: "lib/handlebars/handlebars"
    io:         "lib/socket.io/socket.io"
    socketapp:  "http://localhost:3000/javascripts/app"

require ["jquery", "rails", "apps"], ($, rails, apps) ->
  $ ->
    apps.register()
