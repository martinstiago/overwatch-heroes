# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resources :heroes, only: %i[index show] do
      get :abilities, on: :member
    end
    resources :abilities, only: %i[index show]

    root 'heroes#index'
  end

  root 'api/heroes#index'
end
