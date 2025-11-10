class UserSerializer
  include JSONAPI::Serializer

  attributes :email

  has_many :user_books
  has_many :books
end
