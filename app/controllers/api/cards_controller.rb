module Api
  class CardsController < ApplicationController
    def search
      search_results = Card.search(
        query: search_query,
        size:,
        from:
      )

      cards = search_results.records.to_a

      render json: {
        data: CardSerializer.new(cards).serializable_hash[:data],
        meta: {
          page: params[:page]&.to_i || 1,
          per_page: size,
          total: search_results.response['hits']['total']['value']
        }
      }, status: :ok
    end

    private

    def from
      params[:page] ? (params[:page].to_i - 1) * (params[:per_page] || 25).to_i : 0
    end

    def size
      params[:per_page] || 25
    end

    def search_query
      query = params[:q] || '*'

      {
        query_string: {
          query: query,
          fields: ['name^3', 'type_line^2', 'oracle_text', 'artist'],
          default_operator: 'AND'
        }
      }
    end
  end
end
