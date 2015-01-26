require 'httparty'
require 'fortenet/version'

module Fortenet
  mattr_accessor :api_login_id, :secure_transaction_key, :account_id, :location_id

  mattr_accessor :endpoint
  @@endpoint = 'https://sandbox.forte.net/api/v1'

  mattr_accessor :debug
  @@debug = true

  mattr_accessor :debug_output
  @@debug_output = $stdout

  def self.configure
    yield self
  end

end

require 'fortenet/request'
require 'fortenet/client'