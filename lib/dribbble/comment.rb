module Dribbble
  class Comment < Dribbble::Base
    def self.available_fields
      %i(body)
    end

    def likes
      url = "#{dribbble_url}/likes"
      Dribbble::Like.batch_new token, html_get(url), nil, url
    end

    def like?
      html_get "#{dribbble_url}/like"
      true
    rescue RestClient::ResourceNotFound
      false
    end

    def like!
      res = html_post "#{dribbble_url}/like"
      res.code == 201 ? true : false
    end

    def unlike!
      res = html_delete "#{dribbble_url}/like"
      res.code == 204 ? true : false
    end
  end
end
