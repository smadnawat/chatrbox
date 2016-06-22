Rails.application.routes.draw do

  root "apis/users#home"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get "change_user_status" => "apis/users#change_user_status"
  resources :users, :controller => "apis/users", only: [:create, :update, :show] do
    member do

      get "sign_out"
      get "get_background"
      post "create_report"

      get "my_chatroom", controller: "apis/chatrooms"
      get "get_chatroom", controller: "apis/chatrooms"
      get "my_chatroom_messages", controller: "apis/chatrooms"
      get "chatroom_details", controller: "apis/chatrooms"
      get "leave_group", controller: "apis/chatrooms"
      get "change_chatroom_background", controller: "apis/chatrooms"
      post "mute_chatroom", controller: "apis/chatrooms"
      post "create_chatroom_message", controller: "apis/chatrooms"
      post "add_chatroom", controller: "apis/chatrooms"
      post "contact_us", controller: "apis/contacts"

      get 'get_friend_messages',controller: "apis/friends"
      get 'get_my_friend_list' ,controller: "apis/friends"
      get 'search_friend' ,controller: "apis/friends"
      get 'find_friendship' ,controller: "apis/friends"

      get 'get_blocked_friends',controller: "apis/friends"
      post 'change_single_chat_background',controller: "apis/friends"
      post 'send_message_to_friend'       ,controller: "apis/friends"
      post 'add_block_friend'             ,controller: "apis/friends"
      post 'unblock_friend'               ,controller: "apis/friends"
      post 'mute_single_chat'             ,controller: "apis/friends"


    end
    collection do
      post "login" 
      get "get_location"
      get "about"
      get "faq"
      get "term"
    end
  end

  resources :friends , :controller => "apis/friends", except:[:index,:new,:create,:edit,:show,:update,:destroy] do
    member do

    end
    collection do
    end
  end

end
