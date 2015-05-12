# WialonApi
[![Build Status](https://travis-ci.org/thorn/wialon_api.svg?branch=master)](https://travis-ci.org/thorn/wialon_api)
[![Join the chat at https://gitter.im/thorn/wialon_api](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/thorn/wialon_api?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

`wialon_api` is a ruby client for a [Wialon](http://wialon.com/) web-based GPS tracking software platform [API](http://sdk.wialon.com/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wialon_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wialon_api

## Usage

### Api method call

```ruby
# The first thing to do is to authorize client
client = WialonApi.authorize("wialon_test", "test")

# Now we can use API
client.core.get_account_data(type: 1)
# => {"plan"=>"Gurtam External",
#  "enabled"=>1,
#  "flags"=>16,
#  "created"=>1362386585,
#  "balance"=>"0.00",
#  "daysCounter"=>0,
#  "services"=>
#   ....

# API calls with nested params could be implemented as follows
client.core.search_items({
  "spec" => {
    "itemsType" => "avl_unit",
    "propName" => "sys_name",
    "propValueMask" => "*",
    "sortType" => "sys_name"
  },
  "force" => 1,
  "flags" => 0x3FFFFFFFFFFFFFFF,
  "from" => 0,
  "to" => 0
})

=> {"searchSpec"=>{"itemsType"=>"avl_unit", "propName"=>"sys_name", "propValueMask"=>"*", "sortType"=>"sys_name", "propType"=>""},
# "dataFlags"=>4611686018427387903,
# "totalItemsCount"=>27,
# "indexFrom"=>0,
# "indexTo"=>0,
# "items"=>
#  [{"nm"=>"_TK102",
#    "cls"=>2,
#    "id"=>12417697,
#    "prp"=>{},
#    "crt"=>717313,
#     ..........
```

`wialon_api` uses a list of namespaces from API documentation:

  * core
  * items
  * user
  * resource
  * account
  * unit
  * unit_group
  * retranslator
  * route
  * messages
  * report
  * exchange
  * render
  * file

### Error handling

When wialon server returns an error, the WialonApi::Error exception is raised

```ruby
[1] pry(main)> WialonApi.authorize("wrong_user", "password")
WialonApi::Error: Wialon server https://hst-api.wialon.com/wialon/ajax.html returned error 8: Invalid user name or password
```

### Logging

`wialon_api` logs information in `STDOUT` by default. This can be changed in configuration to any other logger e.g. `Rails.logger`.

Three types of information could be logged:

|                        | configuration key  | default value | log level |
| ---------------------- | ---------------    | ------------  | --------- |
| URL Request            | `log_requests`     | `true`        | `debug`   |
| error response JSON    | `log_errors`       | `true`        | `warn`    |
| success response JSON  | `log_responses`    | `false`       | `debug`   |

In a rails applications with default settings in production mode only server
response errors are logged. In development mode the gem logs server responses
and request URLs.

### Configuration

Global parameters could be set in a block of `WialonApi.configure`:

```ruby
WialonApi.configure do |config|
  # Faraday adapter to make requests with:
  # config.adapter = :net_http

  # Faraday connection options
  # config.faraday_options = {}

  # HTTP verb for API methods (:get or :post)
  # config.http_verb = :post

  # Number of retries when connection is failed
  # config.max_retries = 1


  # Logging parameters:
  # log everything through the rails logger
  config.logger = Rails.logger

  # log requests' URLs
  # config.log_requests = true

  # log response JSON after errors
  # config.log_errors = true

  # log response JSON after successful responses
  # config.log_responses = false

  # Wialon server host
  # config.wialon_host = 'https://hst-api.wialon.com/wialon/ajax.html'

  # Wialon server edition: :hosting, :local, :pro
  # config.wialon_edition = :hosting
end
```

Note that `Wialon Pro` edition uses different parameters in requests, e.g. `ssid` vs `eid` as the session identifier. `WialonApi` gem handles these differences automatically.

`Net::HTTP` is used by default for a HTTP requests. One can choose any [other adapter](https://github.com/technoweenie/faraday/blob/master/lib/faraday/adapter.rb) suported by `faraday`.

Options for faraday connection (e.g. proxy settings or SSL certificates path) could be set through `faraday_options` when configuring `wialon_api`.

The default configuration could be generated in a Rails application using `wialon_api:install` command:

``` sh
$ cd /path/to/app
$ rails generate wialon_api:install
```
## TODO

  * Implement methods from "Other request" documentation section
  * Add documentation

## Contributing

1. Fork it ( https://github.com/[my-github-username]/wialon_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
