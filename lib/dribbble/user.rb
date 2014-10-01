require 'dribbble/bucket'

module Dribbble
  class User < Dribbble::Base
    def self.find(token, id = nil)
      @token = token
      get_user(id)
    end

    def buckets
      Dribbble::Bucket.batch_new token, get("/users/#{id}/buckets")
    end
  end
end
