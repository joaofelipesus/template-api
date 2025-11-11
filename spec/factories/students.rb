FactoryBot.define do
  factory :student do
    sequence(:name) { |n| "Student #{n}" }
    age { 25 }
  end
end
