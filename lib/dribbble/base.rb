require 'dribbble/utils'
require 'dribbble/utils/has_children'

module Dribbble
  class Base
    include Dribbble::Utils
    extend Dribbble::Utils

    include Dribbble::Utils::HasChildren

    attr_reader :token, :dribbble_url

    def initialize(token, json, dribbble_url = '')
      @token = token
      @dribbble_url = dribbble_url

      @raw = json.is_a?(Hash) ? json : JSON.parse(json)

      @raw.each do |k, _v|
        define_singleton_method(k) { @raw[k] } unless self.respond_to?(k)
      end
    end

    def self.batch_new(token, json, kind = nil, url = '')
      json = JSON.parse json unless json.is_a? Hash
      json.map do |obj|
        if kind
          new token, obj[kind], url
        else
          new token, obj, url
        end
      end
    end

    # Get a single bucket
    def get_bucket(id)
      Dribbble::Bucket.new @token, html_get("/buckets/#{id}")
    end

    # Get authenticated user's buckets
    def get_buckets(attrs = {})
      Dribbble::Bucket.batch_new token, html_get('/user/buckets', attrs)
    end

    # Get authenticated user's followers
    def get_followers(attrs = {})
      Dribbble::User.batch_new token, html_get('/user/followers', attrs)
    end

    # Get authenticated user's likes
    def get_likes(attrs = {})
      Dribbble::Shot.batch_new token, html_get('/user/likes', attrs), 'shot'
    end

    # Get a single project
    def get_project(id)
      Dribbble::Project.new @token, html_get("/projects/#{id}")
    end

    # Get authenticated user's followers
    def get_projects(attrs = {})
      Dribbble::Project.batch_new token, html_get('/user/projects', attrs)
    end

    # Get a single Shot
    def get_shot(id)
      Dribbble::Shot.new @token, html_get("/shots/#{id}")
    end

    # Get authenticated user's shots
    def get_shots(attrs = {})
      Dribbble::Shot.batch_new token, html_get('/user/shots', attrs)
    end

    # Get authenticated user's followees shots
    # Limited to first 600 shots regardless of the pagination
    def get_following_shots(attrs = {})
      Dribbble::Shot.batch_new token, html_get('/user/following/shots', attrs)
    end

    # Get authenticated user's teams
    def get_teams(attrs = {})
      Dribbble::Team.batch_new token, html_get('/user/teams', attrs)
    end

    # Get a single User or the authenticated one
    def get_user(id = nil)
      if id
        Dribbble::User.new @token, html_get("/users/#{id}")
      else
        Dribbble::User.new @token, html_get('/user')
      end
    end
  end
end
