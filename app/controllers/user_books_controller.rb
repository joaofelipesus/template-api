class UserBooksController < ApplicationController
  def index
    user_books = current_user.user_books.includes(:book)

    render json: {
      data: user_books.map do |user_book|
        {
          type: 'user_book',
          id: user_book.id.to_s,
          attributes: {
            progress_percentage: user_book.progress_percentage,
            user_id: user_book.user_id,
            book_id: user_book.book_id
          },
          relationships: {
            book: {
              data: {
                type: 'book',
                id: user_book.book.id.to_s
              }
            }
          }
        }
      end,

      included: user_books.map(&:book).uniq.map do |book|
        {
          type: 'book',
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
end
