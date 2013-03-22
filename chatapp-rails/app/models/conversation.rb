class Conversation < ActiveRecord::Base
  attr_accessible :chat_room, :user_active, :user

  belongs_to :user
  belongs_to :chat_room

  def self.mark_user_as_active(chat_room_id, user_id)
    conv = Conversation.where("chat_room_id = ? and user_id = ?", chat_room_id, user_id).first
    if !conv.user_active
      conv.user_active = true
      conv.save
    end
  end

  def self.find_active_users(chat_room_id)
    convs = Conversation.where("chat_room_id = ? and user_active = ?", chat_room_id, true)
    users = []
    convs.each do |conv|
      users << User.find(conv.user_id)
    end
    users
  end
end
