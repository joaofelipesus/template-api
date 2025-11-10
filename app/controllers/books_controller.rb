class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search]

  def search
    books = Book.all
    books = books.where("title LIKE ?", "%#{params[:q]}%") if params[:q].present?

    render json: BookSerializer.new(books, included: [:authors, :subjects]).serializable_hash
  end
end
