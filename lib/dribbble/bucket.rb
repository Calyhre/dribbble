module Dribbble
  class Bucket < Dribbble::Base
    def shots(attrs = {})
      Dribbble::Shot.batch_new token, get("/bucket/#{id}/shots", attrs)
    end
  end
end
