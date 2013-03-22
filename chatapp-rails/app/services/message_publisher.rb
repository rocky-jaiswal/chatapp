class MessagePublisher
  include TorqueBox::Injectors

  def publish_message(msg)
    topic = fetch('/topics/message_topic')
    topic.publish(msg)
  end

end