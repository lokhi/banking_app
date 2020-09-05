FactoryBot.define do
  factory :master_wallet_EUR,class: Wallet  do
    current_balance { 0.00 }
    currency { "EUR" }
    company_id { 1 }
    master { true }
  end
  factory :master_wallet_USD,class: Wallet  do
    current_balance { 0.00 }
    currency { "USD" }
    company_id { 1 }
    master { true }
  end
  factory :master_wallet_GBP,class: Wallet  do
    current_balance { 0.00}
    currency { "GBP" }
    company_id { 1 }
    master { true }
  end
  factory :company2_wallet_EUR,class: Wallet  do
    current_balance { 100.00 }
    currency { "EUR" }
    company_id { 2 }
    master { true }
  end
end
