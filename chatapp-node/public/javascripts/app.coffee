socket = io.connect("http://localhost:3000")

channel = $("#channel").val()

socket.on channel, (data) ->
  user = data.user
  msg = data.body
  ts = data.timestamp
  formattedMessage = '<p><span class="ts">' + ts + '</span><span class="user">' + user + ' : </span><span class="msg">' + msg + '</span>' + '</p>'
  $(".chat-area").append(formattedMessage)
