# Fortenet

Simple Ruby wrapper for Forte Payments REST API

Learn about the Forte Payments REST API at https://www.forte.net/devdocs/api_resources/forte_api_v3.htm

### Installation
Add this line to your application's Gemfile:
```ruby
  # in your Gemfile
  gem 'fortenet'

  # then...
  bundle install
```

### Usage
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
    config.proxy_user =ENV['FORTE_PROXY_USER']
    config.proxy_password = ENV['FORTE_PROXY_PASSWORD']
  end
```

Perform a request
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
