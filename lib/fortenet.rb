require 'httparty'
require 'json'
require 'fortenet/version'

module Fortenet
  mattr_accessor :api_login_id, :secure_transaction_key, :account_id, :location_id, :proxy_host, :proxy_user, :proxy_password

  mattr_accessor :endpoint
  @@endpoint = 'https://sandbox.forte.net/api/v3'

  mattr_accessor :debug
  @@debug = true

  def self.debug=(flag)
    @@debug = flag
    Fortenet::Request.default_options.delete(:debug_output) unless flag
  end

  def self.debug_output=(output)
    return unless debug
    Fortenet::Request.debug_output(output)
  end

  mattr_accessor :proxy_port
  @@proxy_port = 80

  def self.configure
    yield self
  end

end

require 'fortenet/options'
require 'fortenet/request'
require 'fortenet/client'

# default starting point
Fortenet.debug_output = $stdout
