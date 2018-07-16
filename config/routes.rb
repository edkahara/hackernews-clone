Rails.application.routes.draw do
  devise_for :users
  root "submissions#index"
  resources :submissions do
    member do
      put "like", to: "submissions#like"
      put "unlike", to: "submissions#unlike"
    end
    resources :comments
  end
  resources :comments, except: [:new, :show] do
    member do
      put "like", to: "comments#like"
      put "unlike", to: "comments#unlike"
    end
    resources :comments
  end
  get '/newest' => 'pages#newest', as: :newest
  get ':id/not_found' => 'pages#missing', as: :missing
  get ':id' => 'pages#profile'
  get ':id/submissions' => 'pages#user_submissions', as: :user_submissions
  get ':id/comments' => 'pages#user_comments', as: :user_comments
  get ':id/favorites' => 'pages#user_favorites', as: :user_favorites
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
