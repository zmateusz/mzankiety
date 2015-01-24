Mzankiety::Application.routes.draw do

  resources :surveys do
    resources :polls
    get 'votes', on: :member  
    get 'stats', on: :member  
  end

  resources :polls do
    resources :answers
    get 'vote', on: :member
    patch 'vote', on: :member
  end

  resources :polls, :surveys do
    get 'detail', on: :member
    get 'result', on: :member
    get 'setshared', on: :member
    get 'setvotable', on: :member
    patch 'setpassword', on: :member
    patch 'enddate', on: :member
  end

  resources :answers do
    get 'wipe'
    resources :votes
  end

  resources :votes

  post "/polls/:poll_id/vote", to: "votes#create"
  post "/votes", to: "votes#create"
  get "/polls/:poll_id/result", to: "polls#result"
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
