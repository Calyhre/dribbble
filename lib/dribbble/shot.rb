require 'dribbble/utils/findable'
require 'dribbble/utils/creatable'
require 'dribbble/utils/updatable'
require 'dribbble/utils/deletable'
require 'dribbble/attachment'
require 'dribbble/comment'
require 'dribbble/like'

module Dribbble
  class Shot < Dribbble::Base
    include Dribbble::Utils::Findable
    include Dribbble::Utils::Creatable
    include Dribbble::Utils::Updatable
    include Dribbble::Utils::Deletable

    has_many :attachments, :buckets, :comments, :likes, :projects
    has_many :rebounds, as: Dribbble::Shot

    def self.all(token, attrs = {})
      @token = token
      batch_new token, html_get('/shots', attrs)
    end

    def self.available_fields
      %i(title image description tags team_id rebound_source_id)
    end

    def self.after_create(res)
      res.code == 202 ? res.headers[:location].split('/').last : false
    end

    def create_attachment(attrs = {})
      res = html_post "/shots/#{id}/attachments" do |payload|
        Dribbble::Attachment.available_fields.each do |field|
          payload[field] = attrs[field]
        end
      end
      res.code == 202 ? true : false
    end

    def find_attachment(attachment_id)
      Dribbble::Attachment.new token, html_get("/shots/#{id}/attachments/#{attachment_id}")
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

    def rebounds(attrs = {})
      Dribbble::Shot.batch_new token, html_get("/shots/#{id}/rebounds", attrs)
    end
  end
end
