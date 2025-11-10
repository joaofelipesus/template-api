class UserSerializer
  include JSONAPI::Serializer

  attributes :email, :created_at, :updated_at

  has_many :user_books
  has_many :books
end
