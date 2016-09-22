require 'sidekiq/web'

Rails.application.routes.draw do
  root "dashboard#show"
  devise_for :admins, controllers: { sessions: 'admin/sessions' }
  devise_for :users, controllers: { sessions: 'users/sessions', :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, only: [:show, :edit, :update] do
    resources :recommended_posts, only: [:index]
  end

  resources :stories, except: [:index] do
    resources :responses, only: [:create]
  end

  resources :tags, only: [:show]

  get "me/bookmarks" => "dashboard#bookmarks", as: :dashboard_bookmarks
  get "top-articles" => "dashboard#top_articles", as: :top_articles
  get "me/articles/drafts" => "articles#drafts", as: :articles_drafts
  get "me/articles/public" => "articles#published", as: :articles_published
  get "search" => "search#show", as: :search
  get "search/users" => "search#users", as: :search_users
  post "stories/create_and_edit" => "stories#create_and_edit", as: :storie_create_and_edit

  namespace :admin do
    resource :dashboard, only: [:show]
    resources :featured_tags, only: [:create, :destroy]
    resources :featured_posts, only: [:create, :destroy]
  end

  namespace :api do
    resources :notifications, only: [:index] do
      post :mark_as_touched, on: :collection
      post :mark_all_as_read, on: :collection
      post :mark_as_read, on: :member
    end

    get "autocomplete" => "search_autocomplete#index"

    resources :stories, only: [:create, :update, :destroy]
    resources :users, only: [:show]
    resources :likers, only: [:index]
    resources :tag_followers, only: [:index]
    resources :followers, only: [:index]
    resources :following, only: [:index]
    resources :following_tags, only: [:index]
    resources :tags, only: [:create]
    resources :follow_suggestions, only: [:index]

    resources :stories, only: [] do
      resource :likes, only: [:create, :destroy], module: :stories
      resource :bookmarks, only: [:create, :destroy], module: :stories
    end

    resources :responses, only: [] do
      resource :likes, only: [:create, :destroy], module: :responses
      resource :bookmarks, only: [:create, :destroy], module: :responses
    end

    post    "relationships" => "relationships#create"
    delete  "relationships" => "relationships#destroy"
    post    "interests" => "interests#create"
    delete  "interests" => "interests#destroy"
  end

  authenticate :admin do
    mount Sidekiq::Web => '/sidekiq' 
  end
end
