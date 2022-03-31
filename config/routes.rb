# frozen_string_literal: true

Rails.application.routes.draw do
  resources :answers
  resources :questions
  devise_for :users
  get 'welcome/new'
  get 'welcome/index'
  get 'welcome/show'

  post 'like/:id', to: 'answers#like', as: 'like_answer'

  root 'questions#index'
end
