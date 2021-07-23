DEPRECATION NOTICE: The only use of this gem was removed in https://github.com/ArcadiaPower/arcadia-power/pull/9715 and it is now deprecated.

# Fortenet

Simple Ruby wrapper for Forte Payments REST API

Learn about the [Forte Payments REST API](https://www.forte.net/devdocs/api_resources/forte_api_v3.htm)

### Installation
```ruby
  # in your Gemfile
  gem 'fortenet'

  # then...
  bundle install
```

### Setup
Create an initializer
```ruby
  # config/initializers/fortenet.rb
  Fortenet.configure do |config|
    # required configuration
    config.endpoint = ENV['FORTE_ENDPOINT']
    config.api_login_id = ENV['FORTE_API_LOGIN_ID']
    config.secure_transaction_key = ENV['FORTE_SECURE_TRANSACTION_KEY']

    # use the ID values without the prefixes ie. 123456 and not org_123456
    config.account_id = ENV['FORTE_ACCOUNT_ID'] # this is also called organization ID
    config.location_id = ENV['FORTE_LOCATION_ID']

    # optionally configure debug
    config.debug = Rails.env.development?
    config.debug_output = $stdout

    # optionally configure proxy
    config.proxy_host = ENV['FORTE_PROXY_HOST']
    config.proxy_port = ENV['FORTE_PROXY_PORT']
    config.proxy_user = ENV['FORTE_PROXY_USER']
    config.proxy_password = ENV['FORTE_PROXY_PASSWORD']
  end
```

### Usage

`Fortenet::Client` implements `find`, `create`, `update`, and `destroy` for interacting with Forte.

The first arg for all commands is the relative path without any leading backslashes. The second arg for find/create/update is the request data and may either be a hash or a json string.

For example `Fortenet::Client.new.create('transactions, data)` will ensure data is a json string and post to forteat "/organizations/org_#{account_id}/locations/loc_#{location_id}/transactions" with headers setup using initializer config settings for authentication.

Forte client calls will return an [`HTTParty::Response`](http://www.rubydoc.info/github/jnunemaker/httparty/HTTParty/Response) which you can interact with. You can also call `parsed_response` on the actual `Fortenet::Client` instance to get back json parsed hash with symbolized keys.

#### Examples

```ruby
client = Fortenet::Client.new

# sample GET request
client.find('/customers/CUSTOMER_TOKEN')

# sample POST request
request = {
    action: 'force',
    authorization_amount: 240.52,
    billing_address: {
      first_name: 'Test',
      last_name: 'Force'
    },
    echeck: {
     sec_code: 'WEB',
     account_type: 'Checking',
     routing_number: '021000021',
     account_number: '00044422',
     account_holder: 'Marty McFly'
   }
  }
client.create('transactions', request)

# sample PUT request
client.update('transactions', request)
```
