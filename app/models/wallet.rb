class Wallet < ApplicationRecord
  include OriginTransfer
  include TargetTransfer

  validates :current_balance, :currency, :company_id, presence: true

  validates :current_balance, :numericality => { :greater_than_or_equal_to => 0 }
  validates :company_id, numericality: { only_integer: true }
  validates :currency, inclusion: { in: %w(EUR USD GBP),message: "%{value} is not a valid currency" }

  # a company could have uniquely one wallet by currency
  validates :company_id, uniqueness: { scope: :currency }

  def load_money(amount)
    self.current_balance += amount
    self.save!
  end

  def unload_money(amount)
    self.current_balance -= amount
    self.save!
  end

end
