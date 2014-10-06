require 'dribbble/bucket'
require 'dribbble/shot'

module Dribbble
  class User < Dribbble::Base
    def self.find(token, id = nil)
      @token = token
      get_user(id)
    end

    def buckets(attrs = {})
      Dribbble::Bucket.batch_new token, get("/users/#{id}/buckets", attrs)
    end

    def shots(attrs = {})
      Dribbble::Shot.batch_new token, get("/users/#{id}/shots", attrs)
    end
  end
end
