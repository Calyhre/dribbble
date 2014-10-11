require 'dribbble/utils/findable'
require 'dribbble/utils/creatable'
require 'dribbble/utils/updatable'
require 'dribbble/utils/deletable'

module Dribbble
  class Bucket < Dribbble::Base
    include Dribbble::Utils::Findable
    include Dribbble::Utils::Creatable
    include Dribbble::Utils::Updatable
    include Dribbble::Utils::Deletable

    def shots(attrs = {})
      Dribbble::Shot.batch_new token, html_get("/bucket/#{id}/shots", attrs)
    end

    def self.available_fields
      %i(name description)
    end
  end
end
