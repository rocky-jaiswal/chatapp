class ChatRoom < ActiveRecord::Base
  attr_accessible :creator_id, :name, :channel

  has_many :conversations, :dependent => :destroy
  has_many :users, :through => :conversations

  validates :name, :presence => true
  validates :name, :uniqueness => true

  before_save :generate_channel

  #Class methods
  def self.get_owned_by_user(user)
    ChatRoom.where("creator_id = ?", user.id)
  end

  def self.get_accessible_for_user(user)
    conversations = Conversation.where("user_id = ?", user.id)
    rooms = []
    conversations.each do |conv|
      rooms << conv.chat_room
    end
    rooms - get_owned_by_user(user)
  end

  #instance methods
  def generate_channel
    self.channel = SecureRandom.hex(4)
  end
end
