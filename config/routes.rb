Rails.application.routes.draw do
  root "sports#index"
  resource :sports, only: [:index] do
    resources :events, only: [:index, :show]
  end
end

