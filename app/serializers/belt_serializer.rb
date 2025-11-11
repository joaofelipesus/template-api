class BeltSerializer
  include JSONAPI::Serializer

  attributes :name, :presences_required

  has_many :graduations
  has_many :presences
end
