Rails.application.routes.draw do

  devise_for :users

  root to: "billings#index"

  resources :billings, only: [:index] do
    collection do
      get '/new', to: 'billings#new'
      get '/success', to:'billings#success'
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
