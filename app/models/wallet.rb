class Wallet < ApplicationRecord


  validates :current_balance, :currency, :company_id, presence: true

  validates :current_balance, numericality: true
  validates :company_id, numericality: { only_integer: true }
  validates :currency, inclusion: { in: %w(EUR USD GBP),message: "%{value} is not a valid currency" }

  # a company could have uniquely one wallet by currency
  validates :company_id, uniqueness: { scope: :currency }



end
