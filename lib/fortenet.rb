require 'httparty'
require 'fortenet/version'

module Fortenet
  mattr_accessor :endpoint
  @@endpoint = 'https://sandbox.forte.net/api/v1'

  mattr_accessor :api_login_id
  @@api_login_id = 'API_LOGIN'

  mattr_accessor :secure_transaction_key
  @@secure_transaction_key = 'SECURE_TRANSACTION_KEY'

  mattr_accessor :account_id
  @@account_id = 'ACCOUNT_ID'

  mattr_accessor :location_id
  @@location_id = 'LOCATION_ID'

  mattr_accessor :debug
  @@debug = true

  mattr_accessor :debug_output
  @@debug_output = $stdout

  def self.configure
    yield self
  end

end

require 'fortenet/request'
require 'fortenet/node'
require 'fortenet/account'
require 'fortenet/location'
require 'fortenet/transaction'