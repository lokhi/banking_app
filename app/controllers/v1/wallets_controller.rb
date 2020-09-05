module V1
  class WalletsController < ApplicationController

    # GET /wallets
    def index
      @wallets = Wallet.all

      render json: @wallets
    end

    # POST /wallets
    def create
      @wallet = Wallet.new(wallet_params)
      # TODO I think I should add a databse log to save who as created the wallet
      if @wallet.save
        render json: @wallet, status: :created
      else
        render json: @wallet.errors, status: :unprocessable_entity
      end
    end


    private

      # Only allow a trusted parameter "white list" through.
      def wallet_params
        params.require(:wallet).permit(:current_balance, :currency).merge(:company_id => request.headers["Company-Id"])
      end
  end
end
