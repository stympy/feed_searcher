#!/usr/bin/env ruby

require 'json'
require_relative './item_repository.rb'

repository = ItemRepository.new
puts JSON.dump(repository.search(query: { match: { content_html: ARGV[0] } }, sort: { date_published: { order: :desc } }).to_a)
