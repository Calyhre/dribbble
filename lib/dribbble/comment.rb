module Dribbble
  class Comment < Dribbble::Base
    def self.available_fields
      %i(body)
    end
  end
end
