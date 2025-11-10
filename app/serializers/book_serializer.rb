class BookSerializer
  include JSONAPI::Serializer

  attributes :title, :subtitle, :description, :pages, :isbn, :created_at, :updated_at

  has_many :authors
  has_many :subjects
  has_many :user_books
end
