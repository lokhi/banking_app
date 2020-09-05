FactoryBot.define do
  factory :card do
    association :wallet, factory: :company2_wallet_EUR
    currency { "EUR" }
    current_balance { 100.0 }
    numbers { "4242424242424242" }
    expiration_date { "2020-10-05".to_date }
    ccv { "123" }
    user_id { 3 }
    status { 1 }
  end
end
