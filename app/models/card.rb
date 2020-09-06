class Card < ApplicationRecord
    include OriginTransfer
    include TargetTransfer
    belongs_to :wallet


    validates :wallet_id,:current_balance, :currency, :user_id,:numbers,:expiration_date,:ccv,:status, presence: true

    validates :current_balance, :numericality => { :greater_than_or_equal_to => 0 }
    validates :user_id, numericality: { only_integer: true }
    validates :currency, inclusion: { in: %w(EUR USD GBP),message: "%{value} is not a valid currency" }
    validates_length_of :numbers, minimum: 16, maximum: 16, allow_blank: false
    validates_length_of :ccv, minimum: 3, maximum: 3, allow_blank: false

    validate :same_currency_as_wallet



    def same_currency_as_wallet
      if self.wallet && self.currency != self.wallet.currency
        errors.add(:currency, "should be same than wallet")
      end
    end


    def generate
      self.currency = self.wallet.currency if self.wallet
      self.numbers = generate_numbers
      self.expiration_date = Date.today + 1.month
      self.ccv = generate_ccv
    end


    def load_money(amount)
      self.current_balance += amount
      self.save!
    end

    def unload_money(amount)
      self.current_balance -= amount
      self.save!
    end

    def unlock
        self.status = 1
        self.save
    end
    def lock
        self.status = 0
        self.save
    end


    private
      def generate_ccv
        generate_code(3)
      end

      def generate_numbers
        generate_code(16)
      end

      def generate_code(number)
        charset = Array('0'..'9')
        Array.new(number) { charset.sample }.join
      end
end
