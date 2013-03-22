class ChatMessage
  include Mongoid::Document
  
  field :user_email, type: String
  field :body, type: String
  field :chat_room_id, type: Integer
  field :timestamp, type: DateTime


  def self.get_history(chat_room_id)
    ChatMessage.where(:chat_room_id => chat_room_id)
  end
end