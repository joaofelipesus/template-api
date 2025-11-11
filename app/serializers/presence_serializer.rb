class PresenceSerializer
  include JSONAPI::Serializer

  attributes :current_presences_count, :graduate

  belongs_to :student, serializer: StudentSerializer
  belongs_to :current_belt, serializer: :BeltSerializer
end
