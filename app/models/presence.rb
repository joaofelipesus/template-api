class Presence < ApplicationRecord
  belongs_to :student
  belongs_to :current_belt
end
