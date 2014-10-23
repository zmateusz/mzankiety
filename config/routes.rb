Mzankiety::Application.routes.draw do
  resources :polls do
    get 'vote', on: :member
  	resources :answers
  end

  resources :votes

  resources :answers do
    get 'wipe'
    resources :votes
  end

  post "/polls/:poll_id/vote", to: "votes#create"
  post "/votes", to: "votes#create"
  get 'answers', to: "answers#index"
  get 'votes', to: "votes#index"

  
  root "pages#home"    
  get "home", to: "pages#home", as: "home"
  get "inside", to: "pages#inside", as: "inside"
    
  devise_for :users
  
  namespace :admin do
    root "base#index"
    resources :users
  end
  
end
