Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'api/v1/sessions', registrations: 'api/v1/registrations' }
    namespace :api do
    namespace :v1 do
      resources :referrals, only: [:create]
      post 'auth/sign_in', to: 'auth#sign_in'
      post 'auth/sign_up', to: 'auth#sign_up'
    end
  end
end
