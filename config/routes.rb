# frozen_string_literal: true

Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root to: 'rails_admin/main#dashboard'

  namespace :api do
    resources :heroes, only: %i[index show] do
      get :abilities, on: :member
    end
    resources :abilities, only: %i[index show]
    root 'heroes#index'
  end
end
