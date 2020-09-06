class CardLocker < ApplicationService
  def initialize(card,user_id)
    @card = card
    @user_id = user_id
  end

  def call
    wallet = @card.wallet
    ActiveRecord::Base.transaction do
      # we could load the card
      money_in_card = @card.current_balance
      wallet.load_money(money_in_card)
      @card.unload_money(money_in_card)
      @card.lock
      Transfer.create(:amount => money_in_card,:origin_currency => @card.currency,:target_currency => wallet.currency,:origin_transfer => @card, :target_transfer => wallet,:user_id => @user_id)
    end
  end
end
