require 'httparty'
require 'json'

module Fortenet
  class Request
    include HTTParty
    debug_output Fortenet.debug_output if Fortenet.debug
    format :json
    headers 'Accept' => 'application/json'

    def initialize(options = {})
      @api_login_id = options[:api_login_id] || Fortenet.api_login_id
      @secure_transaction_key = options[:secure_transaction_key] || Fortenet.secure_transaction_key
      @secure_transaction_key = options[:account_id] || Fortenet.account_id
      @endpoint = options[:endpoint] || Fortenet.endpoint
      @proxy_host = options[:proxy_host] || Fortenet.proxy_host
      @proxy_port = options[:proxy_port] || Fortenet.proxy_port
      @proxy_user = options[:proxy_user] || Fortenet.proxy_user
      @proxy_password = options[:proxy_password] || Fortenet.proxy_password
    end

    def get(path, options={})
      set_auth(options)
      @response = self.class.get(@endpoint + path, options)
    end

    def post(path, options={})
      set_auth(options)
      @response = self.class.post(@endpoint + path, options)
    end

    def put(path, options={})
      set_auth(options)
      @response = self.class.put(@endpoint + path, options)
    end

    def delete(path, options={})
      set_auth(options)
      @response = self.class.delete(@endpoint + path, options)
    end

    def response
      @response
    end

    def parsed_response
      self.response.parsed_response if self.response.present?
    end

    private

    def set_auth(options)
      client_id_and_secret = Base64.strict_encode64("#{api_login_id}:#{secure_transaction_key}")

      options[:headers] ||= {}
      options[:headers]['X-Forte-Auth-Account-Id'] = "act_#{account_id}"
      options[:headers]["Content-Type"] = "application/json"
      options[:headers]["Accept"] = "application/json"
      options[:headers]['Authorization'] = "Basic #{client_id_and_secret}"

      options[:http_proxyaddr] = @proxy_host if @proxy_host.present?
      options[:http_proxyport] = @proxy_port if @proxy_port.present?
      options[:http_proxyuser] = @proxy_user if @proxy_user.present?
      options[:http_proxypass] = @proxy_password if @proxy_user.present?
    end
  end
end
