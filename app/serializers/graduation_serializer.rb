class GraduationSerializer
  include JSONAPI::Serializer

  attributes :created_at, :updated_at

  attribute :belt_name do |graduation|
    graduation.belt.name
  end


  belongs_to :student, serializer: StudentSerializer
  belongs_to :belt, serializer: BeltSerializer
end
