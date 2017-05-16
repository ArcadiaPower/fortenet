module Fortenet
  class Options
    def initialize(options)
      self.options = options
    end

    def call
      {
        format: :plan,
        headers: header_settings
      }.merge(proxy_settings).merge(options)
    end

    private

      attr_accessor :options

      def proxy_settings
        {}.tap do |options|
          options[:http_proxyaddr] = Fortenet.proxy_host if Fortenet.proxy_host.present?
          options[:http_proxyport] = Fortenet.proxy_port if Fortenet.proxy_port.present?
          options[:http_proxyuser] = Fortenet.proxy_user if Fortenet.proxy_user.present?
          options[:http_proxypass] = Fortenet.proxy_password if Fortenet.proxy_user.present?
        end
      end

      def header_settings
        {
          'X-Forte-Auth-Organization-Id' => "org_#{Fortenet.account_id}",
          'Content-Type' => 'application/json',
          'Authorization' => "Basic #{Base64.strict_encode64("#{Fortenet.api_login_id}:#{Fortenet.secure_transaction_key}")}"
        }
      end
  end
end
