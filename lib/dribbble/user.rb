require 'dribbble/bucket'
require 'dribbble/shot'

module Dribbble
  class User < Dribbble::Base
    def self.find(token, id = nil)
      @token = token
      get_user(id)
    end

    def buckets
      Dribbble::Bucket.batch_new token, get("/users/#{id}/buckets")
    end

    def shots(page: 1, per_page: 100)
      Dribbble::Shot.batch_new token, get("/users/#{id}/shots?page=#{page}&per_page=#{per_page}")
    end
  end
end
