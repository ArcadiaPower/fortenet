module Fortenet
  class Request
    include HTTParty

    format :json
    headers 'Accept' => 'application/json'

    attr_reader :response

    def get(path, **options)
      self.response = self.class.get(Fortenet.endpoint + path, set_auth(options))
    end

    def post(path, **options)
      self.response = self.class.post(Fortenet.endpoint + path, set_auth(options))
    end

    def put(path, **options)
      self.response = self.class.put(Fortenet.endpoint + path, set_auth(options))
    end

    def delete(path, **options)
      self.response = self.class.delete(Fortenet.endpoint + path, set_auth(options))
    end

    def parsed_response
      return if response.nil?

      JSON.parse response.body, symbolize_names: true
    end

    private

      attr_writer :response

      def set_auth(options)
        Fortenet::Options.new(options).call
      end

  end

end
