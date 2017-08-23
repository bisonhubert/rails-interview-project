Rails.application.routes.draw do
  root 'welcome#index'
  get 'welcome/index'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do 
      resources :questions, only: [:index]
    end 
  end 
end
