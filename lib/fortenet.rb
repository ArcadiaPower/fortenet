require 'httparty'
require 'fortenet/version'

module Fortenet
  mattr_accessor :api_login_id, :secure_transaction_key, :account_id, :location_id, :proxy_host, :proxy_user, :proxy_password

  mattr_accessor :endpoint
  @@endpoint = 'https://sandbox.forte.net/api/v1'

  mattr_accessor :debug
  @@debug = true

  mattr_accessor :debug_output
  @@debug_output = $stdout

  mattr_accessor :proxy_port
  @@proxy_port = 80

  def self.configure
    yield self
  end

end

require 'fortenet/request'
require 'fortenet/client'