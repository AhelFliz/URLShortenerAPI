Rails.application.routes.draw do
 resources :shortens do
  member do
    get :stats
  end
 end

 get "up" => "rails/health#show", as: :rails_health_check
end
