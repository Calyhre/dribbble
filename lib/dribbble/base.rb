require 'dribbble/utils'

module Dribbble
  class Base
    include Dribbble::Utils
    extend Dribbble::Utils

    attr_reader :token

    def initialize(token, json)
      @token = token
      @raw = json.is_a?(Hash) ? json : JSON.parse(json)

      @raw.each do |k, v|
        define_singleton_method(k) { @raw[k] }
      end
    end

    def self.batch_new(token, json, kind = nil)
      json = JSON.parse json unless json.is_a? Hash
      json.map do |obj|
        if kind
          new token, obj[kind]
        else
          new token, obj
        end
      end
    end

    # Get a single bucket
    def get_bucket(id)
      Dribbble::Bucket.new @token, get("/buckets/#{id}")
    end

    # Get authenticated user's buckets
    def get_buckets(attrs = {})
      Dribbble::Bucket.batch_new token, get('/user/buckets', attrs)
    end

    # Get authenticated user's followers
    def get_followers(attrs = {})
      Dribbble::User.batch_new token, get('/user/followers', attrs)
    end

    # Get authenticated user's likes
    def get_likes(attrs = {})
      Dribbble::Shot.batch_new token, get('/user/likes', attrs), 'shot'
    end

    # Get a single project
    def get_project(id)
      Dribbble::Project.new @token, get("/projects/#{id}")
    end

    # Get authenticated user's followers
    def get_projects(attrs = {})
      Dribbble::Project.batch_new token, get('/user/projects', attrs)
    end

    # Get a single Shot
    def get_shot(id)
      Dribbble::Shot.new @token, get("/shots/#{id}")
    end

    # Get authenticated user's shots
    def get_shots(attrs = {})
      Dribbble::Shot.batch_new token, get('/user/shots', attrs)
    end

    # Get authenticated user's followees shots
    # Limited to first 600 shots regardless of the pagination
    def get_following_shots(attrs = {})
      Dribbble::Shot.batch_new token, get('/user/following/shots', attrs)
    end

    # Get authenticated user's teams
    def get_teams(attrs = {})
      Dribbble::Team.batch_new token, get('/user/teams', attrs)
    end

    # Get a single User or the authenticated one
    def get_user(id = nil)
      if id
        Dribbble::User.new @token, get("/users/#{id}")
      else
        Dribbble::User.new @token, get('/user')
      end
    end
  end
end
