require 'dribbble/utils/findable'

module Dribbble
  class Project < Dribbble::Base
    extend Dribbble::Utils::Findable

    def shots(attrs = {})
      Dribbble::Shot.batch_new token, get("/projects/#{id}/shots", attrs)
    end
  end
end
