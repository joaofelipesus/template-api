class AuthorSerializer
  include JSONAPI::Serializer

  attributes :name, :created_at, :updated_at

  has_many :books
end
