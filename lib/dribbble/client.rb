require 'dribbble/base'
require 'dribbble/user'
require 'dribbble/bucket'
require 'dribbble/project'
require 'dribbble/shot'
require 'dribbble/team'
require 'dribbble/errors'

require 'rest_client'
require 'json'

module Dribbble
  class Client < Dribbble::Base
    include Dribbble::Utils

    def initialize(token = nil)
      token = token.is_a?(Hash) ? token[:token] : token
      @token = token
      fail Dribbble::Error::MissingToken if @token.nil?
    end

    # Get authenticated user's buckets
    def buckets(attrs = {})
      Dribbble::Bucket.batch_new token, html_get('/user/buckets', attrs)
    end

    # Get authenticated user's followers
    def followers(attrs = {})
      Dribbble::User.batch_new token, html_get('/user/followers', attrs)
    end

    # Get authenticated user's likes
    def likes(attrs = {})
      Dribbble::Shot.batch_new token, html_get('/user/likes', attrs), 'shot'
    end

    # Get authenticated user's followers
    def projects(attrs = {})
      Dribbble::Project.batch_new token, html_get('/user/projects', attrs)
    end

    # Get authenticated user's shots
    def shots(attrs = {})
      Dribbble::Shot.batch_new token, html_get('/user/shots', attrs)
    end

    # Get authenticated user's followees shots
    # Limited to first 600 shots regardless of the pagination
    def following_shots(attrs = {})
      Dribbble::Shot.batch_new token, html_get('/user/following/shots', attrs)
    end

    # Get authenticated user's teams
    def teams(attrs = {})
      Dribbble::Team.batch_new token, html_get('/user/teams', attrs)
    end

    # Get a single User or the authenticated one
    def user
      Dribbble::User.new @token, html_get('/user')
    end
  end
end
