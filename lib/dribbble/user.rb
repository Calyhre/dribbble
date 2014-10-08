require 'dribbble/utils/findable'
require 'dribbble/bucket'
require 'dribbble/project'
require 'dribbble/shot'
require 'dribbble/team'

module Dribbble
  class User < Dribbble::Base
    extend Dribbble::Utils::Findable

    def buckets(attrs = {})
      Dribbble::Bucket.batch_new token, get("/users/#{id}/buckets", attrs)
    end

    def followers(attrs = {})
      Dribbble::User.batch_new token, get("/users/#{id}/followers", attrs)
    end

    def likes(attrs = {})
      Dribbble::Shot.batch_new token, get("/users/#{id}/likes", attrs)
    end

    def projects(attrs = {})
      Dribbble::Project.batch_new token, get("/users/#{id}/projects", attrs)
    end

    def shots(attrs = {})
      Dribbble::Shot.batch_new token, get("/users/#{id}/shots", attrs)
    end

    def teams(attrs = {})
      Dribbble::Team.batch_new token, get("/users/#{id}/teams", attrs)
    end
  end
end
