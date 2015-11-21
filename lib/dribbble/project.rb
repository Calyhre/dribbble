require 'dribbble/utils/findable'

module Dribbble
  class Project < Dribbble::Base
    include Dribbble::Utils::Findable

    def shots(attrs = {})
      Dribbble::Shot.batch_new token, html_get("/projects/#{id}/shots", attrs)
    end
  end
end
