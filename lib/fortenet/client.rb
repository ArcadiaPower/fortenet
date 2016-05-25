module Fortenet
  class Client < Fortenet::Request
    def initialize(options = {})
      @location_id = options[:location_id] || Fortenet.location_id
      @account_id = options[:account_id] || Fortenet.account_id
      super(options)
    end

    def base_path
      "/accounts/act_#{@account_id}/locations/loc_#{@location_id}/"
    end

    def find(relative_path, data = nil)
      self.get(base_path+relative_path, query: data)
    end

    def create(relative_path, data = nil)
      self.post(base_path+relative_path, body: data_to_json(data))
    end

    def update(relative_path, data = nil)
      self.update(base_path+relative_path, body: data_to_json(data))
    end

    def destroy(relative_path)
      self.delete(base_path+relative_path)
    end

    private

    def data_to_json(data)
      data.is_a?(Hash) ? data.to_json : data
    end
  end
end