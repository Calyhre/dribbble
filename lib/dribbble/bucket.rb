module Dribbble
  class Bucket < Dribbble::Base
    def self.find(token, id)
      super
      @client.get_bucket(id)
    end

    def shots(attrs = {})
      Dribbble::Shot.batch_new token, get("/bucket/#{id}/shots", attrs)
    end
  end
end
