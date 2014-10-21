Mzankiety::Application.routes.draw do
  resources :polls do
    get 'vote', on: :member
  	resources :answers do
      resources :votes
    end
  end

  post "/polls/:poll_id/vote", to: "votes#create"
  
  root "pages#home"    
  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"
    
  devise_for :users
  
  namespace :admin do
    root "base#index"
    resources :users
  end
  
end
