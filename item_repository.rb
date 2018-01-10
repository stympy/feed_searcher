require 'feedparser'
require 'elasticsearch/persistence'

class ItemRepository
  include Elasticsearch::Persistence::Repository

  type :item
  klass FeedParser::Item

  # Configure the settings and mappings for the Elasticsearch index
  settings number_of_shards: 1 do
    mapping do
      indexes :date_published, type: 'date'
      indexes :content_html, analyzer: 'snowball'
      indexes :content_text, analyzer: 'snowball'
    end
  end

  def initialize(index_name: :items, url: ENV['ELASTICSEARCH_URL'], log: false)
    index index_name
    client Elasticsearch::Client.new url: url, log: log
  end

  def serialize(item)
    %w(id title url content_html).each_with_object({}) {|attr, hash| hash[attr] = item.send(attr) }.tap do |document|
      document['content_html'] ||= item.summary
      document['date_published'] = item.published || item.updated
      document['date_modified'] = item.updated if item.updated?
      document['external_url'] = item.external_url unless item.external_url.nil?
      %w(content_text authors tags).each do |attr|
        document[attr] = item.send(attr) if item.send("#{attr}?")
      end
    end
  end

  def deserialize(document)
    document['_source']
  end
end
