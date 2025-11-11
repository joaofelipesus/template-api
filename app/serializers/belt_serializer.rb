class BeltSerializer
  include JSONAPI::Serializer

  attributes :name, :presences_required
end
