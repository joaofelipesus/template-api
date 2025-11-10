namespace :elasticsearch do
  desc "Index all cards in Elasticsearch"
  task index_cards: :environment do
    puts "Starting Elasticsearch indexing for cards..."

    begin
      # Delete the index if it exists
      Card.__elasticsearch__.create_index! force: true
      puts "Created Elasticsearch index for cards"

      # Import all cards
      Card.import
      puts "Indexed #{Card.count} cards in Elasticsearch"

      # Refresh the index to make documents available for search
      Card.__elasticsearch__.refresh_index!
      puts "Refreshed Elasticsearch index"

      puts "\nIndexing completed successfully!"
    rescue Faraday::ConnectionFailed => e
      puts "\nError: Could not connect to Elasticsearch."
      puts "Please ensure Elasticsearch is running on elasticsearch:9200"
      puts "Error details: #{e.message}"
      exit 1
    rescue => e
      puts "\nError during indexing: #{e.message}"
      puts e.backtrace.first(5).join("\n")
      exit 1
    end
  end

  desc "Reindex all cards in Elasticsearch"
  task reindex_cards: :environment do
    Rake::Task['elasticsearch:index_cards'].invoke
  end
end
