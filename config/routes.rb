Rails.application.routes.draw do
  namespace :v1 do
    resources :wallets, only: [:index,:create]
    resources :cards, only: [:index,:create]

    patch 'cards/:id/load' => "cards#load",as: "load_card"
    patch 'cards/:id/unload' => "cards#unload",as: "unload_card"
    patch 'cards/:id/lock' => "cards#lock", as:"lock_card"
    patch 'cards/:id/unlock' => "cards#unlock", as:"unlock_card"
    patch 'wallets/:origin_wallet/to/:target_wallet' => "wallets#transfer", as:"transfer_wallet"

  end

end
