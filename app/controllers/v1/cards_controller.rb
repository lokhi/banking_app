module V1
  class CardsController < ApplicationController

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

    private
      # Only allow a trusted parameter "white list" through.
      def card_params
        params.require(:card).permit(:wallet_id).merge(:user_id => request.headers["User-Id"])
      end
  end
end
