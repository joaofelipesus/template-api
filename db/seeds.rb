# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

puts "Creating decks..."

# Create three decks
deck_names = ["Death and Taxes", "Tron", "Goblins"]
decks = deck_names.map do |name|
  Deck.create!(name: name)
end

puts "Created #{decks.count} decks: #{deck_names.join(', ')}"

# Associate 60 random cards to each deck
if Card.count >= 60
  decks.each do |deck|
    puts "Adding 60 random cards to #{deck.name}..."

    # Get 60 random card IDs
    random_cards = Card.order("RANDOM()").limit(60)

    random_cards.each do |card|
      DeckCard.create!(deck: deck, card: card)
    end

    puts "  Added #{deck.cards.count} cards to #{deck.name}"
  end

  puts "\nSeeding completed successfully!"
  puts "Total decks: #{Deck.count}"
  puts "Total cards associated: #{DeckCard.count}"
else
  puts "\nWarning: Not enough cards in database to create decks with 60 cards."
  puts "Please run 'rake cards:import' first to import cards from magic_cards.csv"
end
