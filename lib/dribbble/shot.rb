require 'dribbble/utils/findable'
require 'dribbble/utils/creatable'
require 'dribbble/utils/updatable'
require 'dribbble/utils/deletable'
require 'dribbble/attachment'
require 'dribbble/comment'

module Dribbble
  class Shot < Dribbble::Base
    include Dribbble::Utils::Findable
    include Dribbble::Utils::Creatable
    include Dribbble::Utils::Updatable
    include Dribbble::Utils::Deletable

    def self.all(token, attrs = {})
      @token = token
      batch_new token, html_get('/shots', attrs)
    end

    def self.available_fields
      %i(title image description tags team_id rebound_source_id)
    end

    def self.after_create(res)
      res.code == 202 ? true : false
    end

    def attachments(attrs = {})
      Dribbble::Attachment.batch_new token, html_get("/shots/#{id}/attachments", attrs)
    end

    def buckets(attrs = {})
      Dribbble::Bucket.batch_new token, html_get("/shots/#{id}/buckets", attrs)
    end

    def comments(attrs = {})
      Dribbble::Comment.batch_new token, html_get("/shots/#{id}/comments", attrs)
    end

    def likes(attrs = {})
      Dribbble::User.batch_new token, html_get("/shots/#{id}/likes", attrs), 'user'
    end

    def like?
      html_get "/shots/#{id}/like"
      true
    rescue RestClient::ResourceNotFound
      false
    end

    def like!
      res = html_post "/shots/#{id}/like"
      res.code == 201 ? true : false
    end

    def unlike!
      res = html_delete "/shots/#{id}/like"
      res.code == 204 ? true : false
    end

    def projects(attrs = {})
      Dribbble::Project.batch_new token, html_get("/shots/#{id}/projects", attrs)
    end

    def rebounds(attrs = {})
      Dribbble::Shot.batch_new token, html_get("/shots/#{id}/rebounds", attrs)
    end
  end
end
