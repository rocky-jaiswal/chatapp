class Ability
  include CanCan::Ability

  def initialize(user)
    can [:invite, :add_membership], ChatRoom, :creator_id => user.id
    can :chat, ChatRoom, :conversations => { :user_id => user.id }
  end
end
