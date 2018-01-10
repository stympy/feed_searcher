#!/usr/bin/env ruby

require 'open-uri'
require 'feedparser'
require_relative './item_repository.rb'

LogUtils::Logger.root.level = :info # suppress FeedParser's debug output
logger = LogUtils::Logger.new

repository = ItemRepository.new
repository.create_index!

feed = FeedParser::Parser.parse(open(ARGV[0]).read)
docs = feed.items.map {|i| repository.save(i) }

logger.info "Processed #{ ARGV[0] }: read=#{ docs.size } created=#{ docs.select {|d| d['created'] }.size }"
