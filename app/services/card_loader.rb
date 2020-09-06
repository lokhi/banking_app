class CardLoader < ApplicationService
  def initialize(card,amount,user_id)
    @card = card
    @user_id = user_id
    @amount=amount
  end

  def call
    wallet = @card.wallet
    ActiveRecord::Base.transaction do
      # we could load the card
      wallet.unload_money(@amount)
      @card.load_money(@amount)
      Transfer.create(:amount => @amount,:origin_currency => wallet.currency,:target_currency => @card.currency,:origin_transfer => wallet, :target_transfer => @card,:user_id => @user_id)
    end
  end
end
