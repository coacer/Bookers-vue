Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books, only: [:index, :show, :create, :update, :destroy]
      resource :users, only: [:index, :create, :update] do
        post 'login', on: :collection
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
