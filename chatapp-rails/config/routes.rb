Chatapp::Application.routes.draw do
  
  get "chat_room/new"

  devise_for :users, :skip => [:sessions]
  as :user do
    get    'signin'  => 'devise/sessions#new',     :as => :new_user_session
    post   'signin'  => 'devise/sessions#create',  :as => :user_session
    delete 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  root to: 'pages#login'
  match 'home' => 'pages#home', :as => :home

  delete 'delete_chat_room/:chat_room_id' => 'chat_rooms#destroy', :as => :delete_chat_room
  resource :chat_rooms
  
  get  'invite/:chat_room_id' => 'chat_rooms#invite', :as => :invite
  post 'invite' => 'chat_rooms#add_membership', :as => :post_invite
  get  'chat/:chat_room_id' => 'chat_rooms#chat', :as => :chat
  post 'post_message' => 'chat_rooms#post_message', :as => :post_message
  get  'channels' => 'chat_rooms#channels', :as => :channels
end
