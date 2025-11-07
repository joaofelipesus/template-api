# Elasticsearch configuration
Elasticsearch::Model.client = Elasticsearch::Client.new(
  host: ENV.fetch('ELASTICSEARCH_URL', 'http://elasticsearch:9200'),
  log: false
)
