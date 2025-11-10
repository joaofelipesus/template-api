class BookSerializer
  include JSONAPI::Serializer

  attributes :title, :subtitle, :description, :pages, :isbn

  has_many :authors, serializer: AuthorSerializer
  has_many :subjects, serializer: SubjectSerializer
end
