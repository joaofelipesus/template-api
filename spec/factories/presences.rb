FactoryBot.define do
  factory :presence do
    association :student
    association :current_belt, factory: :belt
  end
end
