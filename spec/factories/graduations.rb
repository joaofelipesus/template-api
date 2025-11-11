FactoryBot.define do
  factory :graduation do
    association :student
    association :belt
  end
end
