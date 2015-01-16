module Fortenet
  class Transaction < Node

    def initialize(account_id = Fortenet.account_id, location_id = Fortenet.location_id,id = nil, attrs = {})
      @id = id
      @location_id = location_id
      @account_id = account_id
      @account = Fortenet::Account.new(account_id)
      @location = Fortenet::Location.new(account_id, location_id)
      @attrs = attrs
    end

    def find
      self.get("#{self.path}/#{@id}")
      self.parsed_response
    end

    def create(attrs = nil)
      self.post(self.path, body: attrs || @attrs)
      self.parsed_response
    end

    def path
      "/accounts/#{@account.prefixed_id}/locations/#{@location.prefixed_id}/transactions"
    end

  end
end