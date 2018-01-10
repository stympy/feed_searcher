# FeedSearcher

This app generates a feed that results from searching a list of feeds.

## Dependencies

You'll need Ruby and bundler installed.  ElasticSearch should be
running.

Run `bundle install` to install the dependencies.

## Indexing a feed

`./fetch.rb http://example.org/atom.xml`

## Running a search

`./search.rb "every term"`
