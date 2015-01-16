module Fortenet
  class Node < Fortenet::Request

    def path
      '/'
    end

    def prefix
      ''
    end

    def prefixed_id
      "#{self.prefix}_#{@id}"
    end

  end
end