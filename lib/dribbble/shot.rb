module Dribbble
  class Shot < Dribbble::Base
    def self.find(token, id)
      super
      @client.get_shot(id)
    end
  end
end
