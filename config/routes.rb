# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :accounts
  get 'u/:id' => 'public#profile', as: :profile

  resources :communities do
    resources :posts do
      member do
        put "upvote", to: "posts#upvote"
        put "downvote", to: "posts#downvote"
      end
    end
    resources :subscriptions
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'public#index'
end
