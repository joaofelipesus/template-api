class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:search]

  def search
    books = Book.all
    books = books.where("title LIKE ?", "%#{params[:q]}%") if params[:q].present?

    render json: {
      data: books.map do |book|
        {
          type: 'books',
          id: book.id.to_s,
          attributes: {
            title: book.title,
            subtitle: book.subtitle,
            description: book.description,
            pages: book.pages,
            isbn: book.isbn
          }
        }
      end
    }
  end

  private

  def skip_authentication?
    action_name == 'search'
  end
end
