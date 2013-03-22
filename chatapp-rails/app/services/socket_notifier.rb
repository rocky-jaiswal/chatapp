class SocketNotifier < TorqueBox::Messaging::MessageProcessor

  def self.publish_new_channel(channel_name)
    $redis.publish("channel_news", channel_name)
  end

  def on_message(msg)
    puts "In SocketNotifier ..."
    puts msg

    $redis.publish(msg[:channel], msg.to_json)
  end

end