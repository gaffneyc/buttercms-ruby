# ButterCMS API Ruby Client

## Documentation

For a comprehensive list of examples, check out the [API documentation](https://buttercms.com/docs/api/).

## Setup

To setup your project, follow these steps:

1. Install using `gem install buttercms-ruby` or by adding to your `Gemfile`:

  ```ruby
  gem 'buttercms-ruby'
  ```

2. Set your API token.

  ```ruby
  require 'buttercms-ruby'

  ButterCMS::api_token = "YourToken"

  # Fetch content from test mode (eg. for your staging website)
  # ButterCMS::test_mode = true
  ```

## Quick Start

```ruby
posts = ButterCMS::Post.all(page: 1, page_size: 10)
puts posts.first.title
puts posts.meta.next_page

posts = ButterCMS::Post.search("my favorite post", {page: 1, page_size: 10})
puts posts.first.title

post = ButterCMS::Post.find("post-slug")
puts post.title

author = ButterCMS::Author.find("author-slug")
puts author.first_name

category = ButterCMS::Category.find("category-slug")
puts category.name

tags = ButterCMS::Tag.all
p tags

rss_feed = ButterCMS::Feed.find(:rss)
puts rss_feed.data

content = ButterCMS::Content.fetch([
  :homepage_html_title,
  :homepage_meta_description,
  :homepage_headline
])
```

## Localization

Setup locales in the ButterCMS dashboard and fetch localized content using the `locale` option:

```ruby
ButterCMS::Content.fetch(['landing_pages'], locale: :es)
```

## Fallback Data Store

This client supports automatic fallback to a data store when API requests fail. When a data store is set, on every successful API request the response is written to the data store. When a subsequent API request fails, the client attempts to fallback to the value in the data store. Currently, Redis and YAML Store are supported.

```ruby
# Use YAMLstore
ButterCMS::data_store = :yaml, "/File/Path/For/buttercms.store"

# Use Redis
ButterCMS::data_store = :redis, ENV['REDIS_URL']

# Set logger (optional)
ButterCMS::logger = MyLogger.new
```

## Test mode

Test mode can be used to setup a staging website for previewing content or for testing content during local development. To fetch content from test mode add the following configuration:

```ruby
ButterCMS::test_mode = true
```