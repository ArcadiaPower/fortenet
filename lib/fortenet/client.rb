module Fortenet
  class Client < Fortenet::Request
    def initialize(account_id = Fortenet.account_id, location_id = Fortenet.location_id)
      self.base_path = "/organizations/org_#{account_id}/locations/loc_#{location_id}/"
    end

    def find(relative_path, data = nil)
      get(base_path + relative_path, query: data)
    end

    def create(relative_path, data = nil)
      post(base_path + relative_path, body: data_to_json(data))
    end

    def update(relative_path, data = nil)
      put(base_path + relative_path, body: data_to_json(data))
    end

    def destroy(relative_path)
      delete(base_path + relative_path)
    end

    private

      attr_accessor :base_path

      def data_to_json(data)
        data.is_a?(Hash) ? data.to_json : data
      end

  end
end
