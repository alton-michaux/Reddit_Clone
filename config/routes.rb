# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :accounts
  get 'u/:id' => 'public#profile', as: :profile

  resources :communities do
    resources :posts
    # resources :subscriptions
  end

  resources :subscriptions
  # post 'subscriptions/' => 'subscriptions#create', as: :new_subscription
  # get 'account/:id/subscriptions' => 'account_subscriptions#index', as: 'account_subscriptions'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'public#index'
end
