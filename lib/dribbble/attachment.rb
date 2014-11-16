module Dribbble
  class Attachment < Dribbble::Base
    def self.available_fields
      %i(file)
    end
  end
end
