class PresenceSerializer
  include JSONAPI::Serializer

  attributes :created_at

  attribute :progress do |presence|
    presence.student.current_belt_presences_count
  end

  belongs_to :student, serializer: StudentSerializer
  belongs_to :current_belt, serializer: BeltSerializer
end
