class UserBookSerializer
  include JSONAPI::Serializer

  attributes :progress_percentage, :created_at, :updated_at

  belongs_to :user
  belongs_to :book
end
