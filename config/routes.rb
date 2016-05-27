Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get "change_user_status" => "apis/users#change_user_status"
  resources :users, :controller => "apis/users", only: [:create, :update, :show] do
    member do
      get "sign_out"
      get "about"
      get "faq"
      get "term"
      get "get_location"
    end
    collection do
    end
  end

end
