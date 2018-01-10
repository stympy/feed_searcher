require 'feedparser'
require 'elasticsearch/persistence'

class ItemRepository
  include Elasticsearch::Persistence::Repository

  type :item
  klass FeedParser::Item

  # Configure the settings and mappings for the Elasticsearch index
  settings number_of_shards: 1 do
    mapping do
      indexes :published, type: 'date'
      indexes :content, analyzer: 'snowball'
    end
  end

  MappedFields = %w(id title url authors published content tags)

  def initialize(index_name: :items, url: ENV['ELASTICSEARCH_URL'], log: false)
    index index_name
    client Elasticsearch::Client.new url: url, log: log
  end

  def serialize(item)
    MappedFields.each_with_object({}) {|attr, hash| hash[attr] = item.send(attr) }.tap do |document|
      document['content'] ||= item.summary
      document['published'] ||= item.updated
    end
  end

  def deserialize(document)
    document['_source']
  end
end
