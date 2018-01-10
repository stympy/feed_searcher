#!/usr/bin/env ruby

require 'json'
require_relative './item_repository.rb'

repository = ItemRepository.new
puts JSON.dump(repository.search(query: { match: { content: ARGV[0] } }, sort: { published: { order: :desc } }).to_a)
