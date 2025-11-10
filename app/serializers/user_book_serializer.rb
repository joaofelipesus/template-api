class UserBookSerializer
  include JSONAPI::Serializer

  attributes :progress_percentage

  belongs_to :user
  belongs_to :book
end
