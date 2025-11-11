# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Belt.find_or_create_by(name: "White", presences_required: 0)
Belt.find_or_create_by(name: "Blue", presences_required: 100)
Belt.find_or_create_by(name: "Purple", presences_required: 250)
Belt.find_or_create_by(name: "Brown", presences_required: 400)
Belt.find_or_create_by(name: "Black", presences_required: 600)
