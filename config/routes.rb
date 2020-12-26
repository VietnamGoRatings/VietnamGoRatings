Rails.application.routes.draw do
  devise_for :users
  root 'players#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :clubs
  resource :users
  namespace :admin do
    resources :clubs do
      collection do
        resources :update_players, controller: 'clubs/update_players'
      end
    end
    resources :tournaments do
    end
  end
end
