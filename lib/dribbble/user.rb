require 'dribbble/utils/findable'

module Dribbble
  class User < Dribbble::Base
    include Dribbble::Utils::Findable

    def buckets(attrs = {})
      Dribbble::Bucket.batch_new token, html_get("/users/#{id}/buckets", attrs)
    end

    def followers(attrs = {})
      Dribbble::User.batch_new token, html_get("/users/#{id}/followers", attrs)
    end

    def following(attrs = {})
      Dribbble::User.batch_new token, html_get("/users/#{id}/following", attrs), 'followee'
    end

    def following?(other_user_id = nil)
      if other_user_id
        html_get "/users/#{id}/following/#{other_user_id}"
      else
        html_get "/user/following/#{id}"
      end
      true
    rescue RestClient::ResourceNotFound
      false
    end

    def follow!
      res = html_put "/users/#{id}/follow"
      res.code == 204 ? true : false
    end

    def unfollow!
      res = html_delete "/users/#{id}/follow"
      res.code == 204 ? true : false
    end

    def likes(attrs = {})
      Dribbble::Shot.batch_new token, html_get("/users/#{id}/likes", attrs), 'shot'
    end

    def projects(attrs = {})
      Dribbble::Project.batch_new token, html_get("/users/#{id}/projects", attrs)
    end

    def shots(attrs = {})
      Dribbble::Shot.batch_new token, html_get("/users/#{id}/shots", attrs)
    end

    def teams(attrs = {})
      Dribbble::Team.batch_new token, html_get("/users/#{id}/teams", attrs)
    end
  end
end
