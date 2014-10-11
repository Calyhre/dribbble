require 'dribbble/utils/findable'
require 'dribbble/utils/creatable'
require 'dribbble/attachment'
require 'dribbble/comment'

module Dribbble
  class Shot < Dribbble::Base
    extend Dribbble::Utils::Findable
    extend Dribbble::Utils::Creatable

    def self.all(token, attrs = {})
      @token = token
      batch_new token, get('/shots', attrs)
    end

    def self.required_fields
      %i(title image description tags team_id rebound_source_id)
    end

    def self.after_create(res)
      res.code == 202 ? true : false
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

    def like?
      get "/shots/#{id}/like"
      true
    rescue RestClient::ResourceNotFound
      false
    end

    def like!
      res = post "/shots/#{id}/like"
      res.code == 201 ? true : false
    end

    def unlike!
      res = delete "/shots/#{id}/like"
      res.code == 204 ? true : false
    end

    def projects(attrs = {})
      Dribbble::Project.batch_new token, get("/shots/#{id}/projects", attrs)
    end

    def rebounds(attrs = {})
      Dribbble::Shot.batch_new token, get("/shots/#{id}/rebounds", attrs)
    end
  end
end
