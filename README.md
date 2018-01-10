# FeedSearcher

This app generates a feed that results from searching a list of feeds.

## Dependencies

You'll need Ruby and bundler installed.  ElasticSearch should be
running.

Run `bundle install` to install the dependencies.

## Indexing a feed

`./fetch.rb http://example.org/atom.xml`

You can specify a list of feeds to index in [feeds.yml](feeds.yml).  If
you don't specify a feed as an option to `fetch.rb`, then this list of
feeds will be fetched.

## Running a search

`./search.rb "every term"`

## Web UI

Run `rackup` and visit http://localhost:9292 in your browser.  When
you submit the form, you'll get back a [JSON feed](https://jsonfeed.org/).
