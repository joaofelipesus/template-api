#!/usr/bin/env ruby

require 'net/http'
require 'json'
require 'csv'
require 'uri'

class MagicCardsFetcher
  BASE_URL = 'https://api.scryfall.com'
  RATE_LIMIT_DELAY = 0.1 # 100 milliseconds as recommended by Scryfall

  def initialize
    @cards = []
  end

  def fetch_cards
    puts "Fetching Magic: The Gathering cards from Scryfall API..."

    # Fetch 20 lands
    puts "Fetching 20 lands..."
    fetch_cards_by_type('t:land', 20)

    # Fetch 140 creatures (half of remaining 280)
    puts "Fetching 140 creatures..."
    fetch_cards_by_type('t:creature', 140)

    # Fetch 140 other spells (remaining cards - excluding lands and creatures)
    puts "Fetching 140 other spells..."
    fetch_cards_by_type('-t:land -t:creature', 140)

    puts "Total cards fetched: #{@cards.length}"
  end

  def generate_csv(filename = 'magic_cards.csv')
    puts "Generating CSV file: #{filename}"

    CSV.open(filename, 'w', write_headers: true, headers: csv_headers) do |csv|
      @cards.each do |card|
        csv << extract_card_data(card)
      end
    end

    puts "CSV file generated successfully with #{@cards.length} cards!"
    puts "File saved as: #{filename}"
  end

  private

  def fetch_cards_by_type(query, count)
    page = 1
    cards_needed = count

    while cards_needed > 0
      cards_per_page = [cards_needed, 175].min # API returns max 175 cards per page

      uri = URI("#{BASE_URL}/cards/search")
      params = {
        'q' => query,
        'page' => page,
        'unique' => 'cards',
        'order' => 'random'
      }
      uri.query = URI.encode_www_form(params)

      response = make_request(uri)

      if response.code == '200'
        data = JSON.parse(response.body)

        if data['data'] && data['data'].any?
          new_cards = data['data'].first(cards_needed)
          @cards.concat(new_cards)
          cards_needed -= new_cards.length

          puts "  Fetched #{new_cards.length} cards (#{count - cards_needed}/#{count})"

          # Check if we have more pages and still need cards
          break unless data['has_more'] && cards_needed > 0

          page += 1
        else
          puts "  No more cards found for query: #{query}"
          break
        end
      else
        puts "  Error fetching cards: HTTP #{response.code}"
        puts "  Response: #{response.body}"
        break
      end

      # Rate limiting - sleep between requests
      sleep(RATE_LIMIT_DELAY)
    end
  end

  def make_request(uri)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri)
    request['User-Agent'] = 'MagicCardsFetcher/1.0'
    request['Accept'] = 'application/json'

    http.request(request)
  end

  def csv_headers
    [
      'name',
      'mana_cost',
      'cmc',
      'type_line',
      'oracle_text',
      'power',
      'toughness',
      'colors',
      'color_identity',
      'rarity',
      'set_name',
      'set',
      'collector_number',
      'artist',
      'released_at',
      'scryfall_uri',
      'card_category'
    ]
  end

  def extract_card_data(card)
    # Determine card category
    type_line = card['type_line'] || ''
    category = if type_line.downcase.include?('land')
                 'Land'
               elsif type_line.downcase.include?('creature')
                 'Creature'
               else
                 'Spell'
               end

    [
      card['name'],
      card['mana_cost'],
      card['cmc'],
      card['type_line'],
      card['oracle_text'],
      card['power'],
      card['toughness'],
      format_colors(card['colors']),
      format_colors(card['color_identity']),
      card['rarity'],
      card['set_name'],
      card['set'],
      card['collector_number'],
      card['artist'],
      card['released_at'],
      card['scryfall_uri'],
      category
    ]
  end

  def format_colors(colors)
    return '' unless colors && colors.any?
    colors.join(',')
  end
end

# Main execution
if __FILE__ == $0
  fetcher = MagicCardsFetcher.new

  begin
    fetcher.fetch_cards
    fetcher.generate_csv

    puts "\n" + "="*50
    puts "Magic Cards Fetcher completed successfully!"
    puts "Check the 'magic_cards.csv' file for your data."
    puts "="*50

  rescue => e
    puts "An error occurred: #{e.message}"
    puts e.backtrace
  end
end
