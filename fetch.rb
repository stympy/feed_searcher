#!/usr/bin/env ruby

require 'open-uri'
require 'feedparser'
require_relative './item_repository.rb'

LogUtils::Logger.root.level = :info # suppress FeedParser's debug output
logger = LogUtils::Logger.new

repository = ItemRepository.new
repository.create_index!

begin
  urls = ARGV[0].present? ? Array(ARGV[0]) : YAML.load_file('feeds.yml')
rescue Errno::ENOENT
  logger.error "No feed URLs provided"
end

urls.each do |url|
  feed = FeedParser::Parser.parse(open(url).read)
  docs = feed.items.map {|i| repository.save(i) }

  logger.info "Processed #{ url }: read=#{ docs.size } created=#{ docs.select {|d| d['created'] }.size }"
end
