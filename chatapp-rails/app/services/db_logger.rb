class DBLogger < TorqueBox::Messaging::MessageProcessor

  def on_message(msg)
    puts "In DBLogger ..."
    puts msg

    cm = ChatMessage.new
    cm.user_email = msg[:user]
    cm.body = msg[:body]
    cm.chat_room_id = msg[:chat_room_id]
    cm.timestamp = msg[:timestamp]
    cm.save()
  end

end