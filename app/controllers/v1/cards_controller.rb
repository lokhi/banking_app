module V1
  class CardsController < ApplicationController
    before_action :set_card, only: [:load, :unload, :lock, :unlock]
    before_action :check_ownership, only: [:load, :unload, :lock, :unlock]
    before_action only: [:load, :unload] do
      check_amount(params[:amount])
    end



    # GET /cards
    def index
      @cards = Card.where(:user_id =>request.headers["User-Id"])

      render json: @cards
    end

    # POST /cards
    def create
      @card = Card.new(card_params)
      @card.generate
      if @card.save
        render json: @card, status: :created
      else
        render json: @card.errors, status: :unprocessable_entity
      end
    end

    # PATCH /cards/:id/load
    def load
      CardLoader.call(@card,params[:amount],request.headers["User-Id"])
      head :ok
    end

    # PATCH /cards/:id/load
    def unload
      CardUnloader.call(@card,params[:amount],request.headers["User-Id"])
      head :ok
    end

    # Patch /cards/:id/lock
    def lock
      CardLocker.call(@card,request.headers["User-Id"])
      head :ok
    end

    # Patch /cards/:id/unlock
    def unlock
      @card.unlock
      head :ok
    end

    private
      # Only allow a trusted parameter "white list" through.
      def card_params
        params.require(:card).permit(:wallet_id).merge(:user_id => request.headers["User-Id"])
      end

      def unvalid_record
        render json: { :errors => "error" }, status: :unprocessable_entity
      end

      def set_card
        @card = Card.find(params[:id])
      end

      def check_ownership
        if request.headers["User-Id"] != @card.user_id
            raise ApplicationController::Forbidden
        end
      end


  end
end
