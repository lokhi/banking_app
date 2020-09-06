class WalletTransfer < ApplicationService

  def initialize(origin_wallet,target_wallet,amount,user_id)
    @origin_wallet = origin_wallet
    @target_wallet = target_wallet
    @amount = amount
    @user_id = user_id
  end

  def call
    ActiveRecord::Base.transaction do
      target_amount_convert = Conversion.call(@origin_wallet.currency,@target_wallet.currency,@amount)
      @origin_wallet.unload_money(@amount)
      conversion_fee = target_amount_convert * 0.029
      final_amount = target_amount_convert - conversion_fee
      @target_wallet.load_money(final_amount)
      master_wallet = Wallet.where(:master => 1).find_by_currency("USD")
      master_wallet.load_money(conversion_fee)
      Transfer.create(:amount => @amount,:conversion_fee => conversion_fee,:origin_currency => @origin_wallet.currency,:target_currency => @target_wallet.currency,:origin_transfer => @origin_wallet, :target_transfer => @target_wallet,:user_id => @user_id)
      # Log the fee transfer not sure if good thing so I let it in comments to speak about it
      #Transfer.create(:amount => conversion_fee,:origin_currency => @target_wallet.currency,:target_currency => @master_wallet.currency,:origin_transfer => @target_wallet, :target_transfer => @master_wallet,:user_id => @user_id)
    end
  end
end
