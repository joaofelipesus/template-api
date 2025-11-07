module Api
  class DecksController < ApplicationController
    def index
      decks = Deck.includes(:cards).order(name: :asc)

      render json: DeckSerializer.new(decks).serializable_hash.to_json
    end

    def show
      deck = Deck.includes(:cards).find(params[:id])

      render json: DeckSerializer.new(deck, include: [:cards]).serializable_hash.to_json, status: :ok
    end
  end
end
