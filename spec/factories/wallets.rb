FactoryBot.define do
  factory :master_wallet_EUR,class: Wallet   do
    id { 1 }
    current_balance { 0.00 }
    currency { "EUR" }
    company_id { 1 }
    master { true }
  end
  factory :master_wallet_USD,class: Wallet do
    id { 2 }
    current_balance { 0.00 }
    currency { "USD" }
    company_id { 1 }
    master { true }
  end
  factory :master_wallet_GBP,class: Wallet  do
    id { 3 }
    current_balance { 0.00}
    currency { "GBP" }
    company_id { 1 }
    master { true }
  end
  factory :company2_wallet_EUR,class: Wallet   do
    id { 4 }
    current_balance { 100.00 }
    currency { "EUR" }
    company_id { 2 }
    master { false }
    initialize_with { Wallet.find_or_initialize_by(id: 4) }
  end
  factory :company2_wallet_USD,class: Wallet   do
    id { 5 }
    current_balance { 100.00 }
    currency { "USD" }
    company_id { 2 }
    master { false }
    initialize_with { Wallet.find_or_initialize_by(id: 5) }
  end
  factory :company3_wallet_USD,class: Wallet   do
    id { 6 }
    current_balance { 100.00 }
    currency { "USD" }
    company_id { 3 }
    master { false }
    initialize_with { Wallet.find_or_initialize_by(id: 6) }
  end
end
