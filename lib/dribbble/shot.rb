require 'dribbble/utils/findable'

module Dribbble
  class Shot < Dribbble::Base
    extend Dribbble::Utils::Findable

    def self.all(token, attrs = {})
      @token = token
      batch_new token, get('/shots', attrs)
    end
  end
end
