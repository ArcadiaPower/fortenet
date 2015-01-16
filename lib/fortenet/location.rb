module Fortenet
  class Location < Node

    def initialize(account_id = Fortenet.account_id, id = Fortenet.location_id, attrs = {})
      @id = id
      @account_id = account_id
      @account = Fortenet::Account.new(account_id)
    end

    def transactions
      self.get(self.path+'/transactions')
      self.parsed_response
    end

    def path
      "/accounts/#{@account.prefixed_id}/locations/#{self.prefixed_id}"
    end

    def prefix
      'loc'
    end

  end
end