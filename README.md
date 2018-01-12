# FeedSearcher

This app generates a feed that results from searching a list of feeds.

The idea for this project started with a [suggestion from Brent
Simmons][1].

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

## Deployment

Use the Heroku button for the easiest deployment:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

This will add the free Bonsai and Heroku Scheduler addons for you.
After deploying, set up a scheduled job to fetch your feeds by running
`heroku addons:open scheduler`.  Add a job to run `./fetch.rb` as often as
you'd like feeds to be fetched and indexed for search.

To get the party started quickly, run `heroku run ./fetch.rb` to get
your feeds indexed.  Doing a search in the web UI before the first fetch
has been done will result in an error.

[1]:http://inessential.com/2018/01/09/app_idea_mentions
