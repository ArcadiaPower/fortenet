require 'httparty'
require 'json'

module Fortenet
  class Request
    include HTTParty
    debug_output Fortenet.debug_output if Fortenet.debug
    format :json
    headers 'Accept' => 'application/json'

    def get(path, options={})
      set_auth(options)
      @response = self.class.get(Fortenet.endpoint + path, options)
    end

    def post(path, options={})
      set_auth(options)
      @response = self.class.post(Fortenet.endpoint + path, options)
    end

    def put(path, options={})
      set_auth(options)
      @response = self.class.put(Fortenet.endpoint + path, options)
    end

    def delete(path, options={})
      set_auth(options)
      @response = self.class.delete(Fortenet.endpoint + path, options)
    end

    def response
      @response
    end

    def parsed_response
      self.response.parsed_response if self.response.present?
    end

    private

    def set_auth(options)
      client_id_and_secret = Base64.strict_encode64("#{Fortenet.api_login_id}:#{Fortenet.secure_transaction_key}")
      #options[:ssl_version] = :TLSv1
      options[:headers] ||= {}
      options[:headers]['X-Forte-Auth-Account-Id'] = "act_#{Fortenet.account_id}"
      options[:headers]["Content-Type"] = "application/json"
      options[:headers]['Authorization'] = "Basic #{client_id_and_secret}"

      options[:http_proxyaddr] = Fortenet.proxy_host if Fortenet.proxy_host.present?
      options[:http_proxyport] = Fortenet.proxy_port if Fortenet.proxy_port.present?
      options[:http_proxyuser] = Fortenet.proxy_user if Fortenet.proxy_user.present?
      options[:http_proxypass] = Fortenet.proxy_password if Fortenet.proxy_user.present?
    end

  end

end