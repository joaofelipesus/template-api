FactoryBot.define do
  factory :belt do
    sequence(:name) { |n| "Belt #{n}" }
    presences_required { 10 }
    sequence(:sequence_index) { |n| n }

    trait :white do
      name { "White" }
      presences_required { 10 }
      sequence_index { 1 }
    end

    trait :yellow do
      name { "Yellow" }
      presences_required { 15 }
      sequence_index { 2 }
    end

    trait :black do
      name { "Black" }
      presences_required { 0 }
      sequence_index { 10 }
    end
  end
end
