require 'dribbble/utils/findable'
require 'dribbble/attachment'
require 'dribbble/comment'

module Dribbble
  class Shot < Dribbble::Base
    extend Dribbble::Utils::Findable

    def self.all(token, attrs = {})
      @token = token
      batch_new token, get('/shots', attrs)
    end

    def attachments(attrs = {})
      Dribbble::Attachment.batch_new token, get("/shots/#{id}/attachments", attrs)
    end

    def buckets(attrs = {})
      Dribbble::Bucket.batch_new token, get("/shots/#{id}/buckets", attrs)
    end

    def comments(attrs = {})
      Dribbble::Comment.batch_new token, get("/shots/#{id}/comments", attrs)
    end

    def likes(attrs = {})
      Dribbble::User.batch_new token, get("/shots/#{id}/likes", attrs), 'user'
    end
  end
end
