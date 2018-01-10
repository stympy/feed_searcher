#!/usr/bin/env ruby

require 'sinatra'
require 'json'
require_relative './item_repository.rb'

get '/' do
  if params['q'].present?
    repository = ItemRepository.new
    title = params['title'].present? ? params['title'] : "Search: #{ params['q'] }"
    payload = {
      version: "https://jsonfeed.org/version/1",
      title: title.gsub(%r{</?[^>]+?>}, ''),
      items: repository.search(query: { match: { content_html: params['q'] } }, sort: { date_published: { order: :desc } }).to_a
    }
    [ 200, { "Content-type" => "application/json" }, JSON.dump(payload) ]
  else
    erb :index
  end
end

__END__

@@ index
<html>
  <body>
    <form>
      <input type="text" name="q">
      <input type="submit" value="Search">
    </form>
  </body>
</html>
