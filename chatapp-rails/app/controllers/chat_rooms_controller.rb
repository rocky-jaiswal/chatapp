class ChatRoomsController < ApplicationController

  def new
    @chatroom = ChatRoom.new
  end

  def create
    @chatroom = ChatRoom.new(params[:chat_room])
    @chatroom.creator_id = current_user.id

    if @chatroom.save
      conversation = Conversation.create(:chat_room => @chatroom, :user => current_user)
      SocketNotifier.publish_new_channel(@chatroom.channel)
      redirect_to home_path, notice: "Chat Room created successfully."
    else
      render 'new'
    end
  end

  def destroy
    chatroom = ChatRoom.find(params[:chat_room_id])
    chatroom.destroy

    redirect_to home_path, notice: "Chat Room deleted successfully."
  end

  def invite
    @chatroom = ChatRoom.find(params[:chat_room_id])
    authorize! :invite, @chatroom
  end

  def add_membership
    @chatroom = ChatRoom.find(params[:chat_room_id])
    authorize! :add_membership, @chatroom
    
    @user = User.find_by_email(params[:user_email])
    if @user
      conversation = Conversation.create(:chat_room => @chatroom, :user => @user)
      redirect_to home_path, notice: "User invited successfully." and return
    else
      redirect_to invite_path(@chatroom.id), notice: "User not found." and return
    end
  end

  def chat
    @chatroom = ChatRoom.find(params[:chat_room_id])
    authorize! :chat, @chatroom

    Conversation.mark_user_as_active(@chatroom.id, current_user.id)
    @active_users = Conversation.find_active_users(@chatroom.id)
    session[:chat_room_id] = @chatroom.id
    @chathistory = ChatMessage.get_history(@chatroom.id)
  end

  def post_message
    redirect_to home_path unless session[:chat_room_id]

    if request.xhr?
      chatroom = ChatRoom.find(session[:chat_room_id])
      authorize! :chat, chatroom

      message_publisher = MessagePublisher.new
      msg = params[:message]
      message = {:user => current_user.email, :body => msg, :chat_room_id => chatroom.id, :timestamp => DateTime.now.iso8601(0), :channel => chatroom.channel}
      message_publisher.publish_message(message)
      render :json => {:success => "message received"}.to_json
    end
  end

  def channels
    render :json => ChatRoom.all.map(&:channel).to_json
  end

end
