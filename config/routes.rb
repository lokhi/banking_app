Rails.application.routes.draw do
  namespace :v1 do
    resources :wallets, only: [:index,:create]
    resources :cards
  end

end
