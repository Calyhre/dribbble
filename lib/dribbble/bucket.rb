require 'dribbble/utils/findable'
require 'dribbble/utils/creatable'

module Dribbble
  class Bucket < Dribbble::Base
    extend Dribbble::Utils::Findable
    extend Dribbble::Utils::Creatable

    def shots(attrs = {})
      Dribbble::Shot.batch_new token, get("/bucket/#{id}/shots", attrs)
    end

    def self.required_fields
      %i(name description)
    end
  end
end
