Rails.application.routes.draw do

  root "apis/users#home"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get "change_user_status" => "apis/users#change_user_status"
  resources :users, :controller => "apis/users", only: [:create, :update, :show] do
    member do
      get "sign_out"
      get "get_background"
      get "my_chatroom", controller: "apis/chatrooms"
      get "get_chatroom", controller: "apis/chatrooms"
      get "my_chatroom_messages", controller: "apis/chatrooms"
      get "chatroom_details", controller: "apis/chatrooms"
      get "leave_group", controller: "apis/chatrooms"
      get "change_chatroom_background", controller: "apis/chatrooms"
      post "mute_chat", controller: "apis/chatrooms"
      post "create_chatroom_message", controller: "apis/chatrooms"
      post "add_chatroom", controller: "apis/chatrooms"
      post "contact_us", controller: "apis/contacts"
    end
    collection do
      post "login"
      get "get_location"
      get "about"
      get "faq"
      get "term"
    end
  end

end
