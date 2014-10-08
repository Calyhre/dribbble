require 'dribbble/utils/findable'
require 'dribbble/attachment'

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
  end
end
