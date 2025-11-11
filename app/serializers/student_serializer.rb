class StudentSerializer
  include JSONAPI::Serializer

  attributes :name, :age

  has_many :presences, serializer: PresenceSerializer
  has_many :graduations, serializer: GraduationSerializer
end
