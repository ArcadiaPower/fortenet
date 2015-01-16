module Fortenet
  class Account < Node

    attr_reader :locations

    def initialize(id = Fortenet.account_id, attrs = {})
      @id = id
    end

    def path
      "/accounts/#{@id}/"
    end

    def prefix
      'act'
    end

  end
end