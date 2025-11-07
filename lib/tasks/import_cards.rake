require 'csv'

namespace :cards do
  desc "Import cards from magic_cards.csv file"
  task import: :environment do
    csv_file = Rails.root.join('magic_cards.csv')

    unless File.exist?(csv_file)
      puts "Error: magic_cards.csv file not found!"
      exit 1
    end

    puts "Starting card import from #{csv_file}..."

    imported_count = 0
    skipped_count = 0

    CSV.foreach(csv_file, headers: true, header_converters: :symbol) do |row|
      begin
        Card.create!(
          name: row[:name],
          mana_cost: row[:mana_cost],
          cmc: row[:cmc],
          type_line: row[:type_line],
          oracle_text: row[:oracle_text],
          power: row[:power],
          toughness: row[:toughness],
          colors: row[:colors],
          color_identity: row[:color_identity],
          rarity: row[:rarity],
          set_name: row[:set_name],
          set: row[:set],
          collector_number: row[:collector_number],
          artist: row[:artist],
          released_at: row[:released_at],
          scryfall_uri: row[:scryfall_uri],
          card_category: row[:card_category]
        )
        imported_count += 1
        print "\rImported: #{imported_count} cards" if imported_count % 10 == 0
      rescue => e
        skipped_count += 1
        puts "\nSkipped card due to error: #{row[:name]} - #{e.message}"
      end
    end

    puts "\n\nImport completed!"
    puts "Total imported: #{imported_count} cards"
    puts "Total skipped: #{skipped_count} cards" if skipped_count > 0
  end
end
