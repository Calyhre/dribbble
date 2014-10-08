require 'dribbble/utils/findable'

module Dribbble
  class Bucket < Dribbble::Base
    extend Dribbble::Utils::Findable

    def shots(attrs = {})
      Dribbble::Shot.batch_new token, get("/bucket/#{id}/shots", attrs)
    end
  end
end
