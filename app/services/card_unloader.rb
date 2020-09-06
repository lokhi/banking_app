class CardUnloader < ApplicationService

  def initialize(card,amount,user_id)
    @card = card
    @user_id = user_id
    @amount = amount
  end

  def call
    wallet = @card.wallet
    ActiveRecord::Base.transaction do
      wallet.load_money(@amount)
      @card.unload_money(@amount)
      Transfer.create(:amount => @amount,:origin_currency => @card.currency,:target_currency => @card.wallet.currency,:origin_transfer => @card, :target_transfer => @card.wallet,:user_id => @user_id)
    end
  end
end
