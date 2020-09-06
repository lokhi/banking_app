module V1
  class WalletsController < ApplicationController
    before_action :set_wallets, only: [:transfer]
    before_action :check_ownership, only: [:transfer]
    before_action only: [:transfer] do
      check_amount(params[:amount])
    end


    # GET /wallets
    def index
      @wallets = Wallet.where(:company_id =>request.headers["Company-Id"])

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

    # PATCH /cards/:id/load
    def transfer
      if WalletTransfer.call(@origin_wallet,@target_wallet,params[:amount],request.headers["User-Id"])
        head :ok
      else
        render json: {:errors => "error" }, status: :unprocessable_entity
      end
    end




    private

      # Only allow a trusted parameter "white list" through.
      def wallet_params
        params.require(:wallet).permit(:current_balance, :currency).merge(:company_id => request.headers["Company-Id"])
      end

      def set_wallets
        @origin_wallet = Wallet.find(params[:origin_wallet])
        @target_wallet = Wallet.find(params[:target_wallet])
      end

      def check_ownership
        if request.headers["Company-Id"] != @origin_wallet.company_id || request.headers["Company-Id"] != @target_wallet.company_id
            raise ApplicationController::Forbidden
        end

        if(@origin_wallet.company_id != @target_wallet.company_id)
          raise ApplicationController::Forbidden
        end
      end
  end
end
