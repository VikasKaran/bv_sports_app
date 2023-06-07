Rails.application.routes.draw do
  root "sports#index"
  resources :sports, only: [:index] do
    resources :events, only: [:index, :show]
  end
end

