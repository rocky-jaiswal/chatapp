class PagesController < ApplicationController

  def login
    redirect_to home_path and return if user_signed_in?
  end
  
  def home
    @owned_chatrooms      = ChatRoom.get_owned_by_user(current_user)
    @accessible_chatrooms = ChatRoom.get_accessible_for_user(current_user)
  end

end
