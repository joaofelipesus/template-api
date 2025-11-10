class UserBooksController < ApplicationController
  def index
    user_books = current_user.user_books.includes(:book)

    render(json: UserBookSerializer.new(user_books, include: [:book]).serializable_hash)
  end
end
