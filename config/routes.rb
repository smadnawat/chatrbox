Rails.application.routes.draw do

  root "apis/users#home"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get "change_user_status" => "apis/users#change_user_status"
  resources :users, :controller => "apis/users", only: [:create, :update, :show] do
    member do
      get "sign_out"
      get "get_location"
      get "get_background"
      get "get_chatroom", controller: "apis/chatrooms"
      get "add_chatroom", controller: "apis/chatrooms"
      post "contact_us", controller: "apis/contacts"
    end
    collection do
      get "about"
      get "faq"
      get "term"
    end
  end

end
