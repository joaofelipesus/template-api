class GraduationSerializer
  include JSONAPI::Serializer

  attributes :created_at, :updated_at

  belongs_to :student, serializer: StudentSerializer
  belongs_to :belt, serializer: BeltSerializer
end
