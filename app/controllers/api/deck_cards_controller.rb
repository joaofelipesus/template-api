module Api
  class DeckCardsController < ApplicationController
    def create
      deck_card = DeckCard.new(deck_card_params)

      if deck_card.save
        render(
          json: DeckCardSerializer.new(deck_card, include: [:deck, :card]).serializable_hash.to_json,
          status: :created
        )
      else
        render json: { errors: deck_card.errors.full_messages.map { |msg| { detail: msg } } }, status: :unprocessable_entity
      end
    end

    def deck_card_params
      params.permit(:deck_id, :card_id)
    end
  end
end
