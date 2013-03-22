define ["jquery", "underscore", "backbone", "socketapp"], ($, _, Backbone, SocketApp) ->
  'use strict'
  
  class TypeAreaView extends Backbone.View
    
    el: ".type-area"

    ENTER_KEY: 13

    events:
      "keypress #chat-message":  "postDataToServer"
    
    initialize: ->
      @input = $("#chat-message")

    postDataToServer: (e) ->
      return  if e.which isnt @ENTER_KEY or not @input.val().trim()
      e.preventDefault()
      msg = @input.val().trim()
      @input.val("")
      @ajaxPost(msg)

    ajaxPost: (msg) ->
      $.ajax
        type: "POST"
        url: "/post_message"
        data: {message: msg}
