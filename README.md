# PornhubApi

[![Gem Version](https://badge.fury.io/rb/pornhub_api.svg)](https://badge.fury.io/rb/pornhub_api)

Simple Pornhub API client

Please check [documentation](https://rubydoc.info/gems/pornhub_api/PornhubApi) and [schemas](spec/schemas) to explore
possible responses

```ruby
require 'pornhub_api'

# the simplest call 
PornhubApi.search

# adjust your search
PornhubApi.search(search: 'lana rhoades', thumbsize: 'small', ordering: 'mostviewed')

# All possible methods
PornhubApi.search
PornhubApi.stars
PornhubApi.stars_detailed
PornhubApi.video_by_id(id: 'ph5f59beb3df90a')
PornhubApi.is_video_active(id: 'ph5f59beb3df90a')
PornhubApi.categories
PornhubApi.tags(list: 'a')
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pornhub_api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install pornhub_api

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. 
You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/qelphybox/pornhub_api.

## Roadmap
    - Binary executable file
    - News RSS feed requests
