class Student < ApplicationRecord
  has_many :presences, dependent: :destroy
  has_many :graduations, dependent: :destroy

  validates :name, :age, presence: true

  def belt
    graduations.includes(:belt).order(created_at: :desc).first.belt
  end

  def current_belt_presences_count
    presences.where(current_belt: belt).count
  end

  def add_presence
    presences.create(current_belt: belt)

    return if belt.black?

    graduate!
  end

  def self.create_new_student!(name:, age:)
    student = create!(name:, age:)
    Graduation.create!(student:, belt: Belt.white)

    student.reload
  end

  private

  def graduate!
    if belt.presences_required == current_belt_presences_count
      new_belt = current_graduation.next

      graduations.create!(belt: new_belt)
    end
  end
end
