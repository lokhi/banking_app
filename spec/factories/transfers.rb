FactoryBot.define do
  factory :transfer do
    amount { 9.99 }
    origin_currency { "EUR" }
    target_currency { "EUR" }
    conversion_fee { 0.00 }
    origin_transfer { |o| o.association(:company2_wallet_EUR) }
    target_transfer {|t| t.association(:card)}
  end
end
