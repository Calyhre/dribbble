require 'dribbble/utils/findable'
require 'dribbble/utils/creatable'

module Dribbble
  class Bucket < Dribbble::Base
    include Dribbble::Utils::Findable
    include Dribbble::Utils::Creatable

    def shots(attrs = {})
      Dribbble::Shot.batch_new token, get("/bucket/#{id}/shots", attrs)
    end

    def self.available_fields
      %i(name description)
    end
  end
end
