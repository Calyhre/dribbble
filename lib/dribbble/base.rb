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

      @raw = json.is_a?(Hash) ? json : JSON.parse(json)
      @dribbble_url = build_dribbble_url(@raw['id'].to_s, dribbble_url)

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
    alias_method :buckets, :get_buckets

    # Get authenticated user's followers
    def get_followers(attrs = {})
      Dribbble::User.batch_new token, html_get('/user/followers', attrs)
    end
    alias_method :followers, :get_followers

    # Get authenticated user's likes
    def get_likes(attrs = {})
      Dribbble::Shot.batch_new token, html_get('/user/likes', attrs), 'shot'
    end
    alias_method :likes, :get_likes

    # Get a single project
    def get_project(id)
      Dribbble::Project.new @token, html_get("/projects/#{id}")
    end

    # Get authenticated user's followers
    def get_projects(attrs = {})
      Dribbble::Project.batch_new token, html_get('/user/projects', attrs)
    end
    alias_method :projects, :get_projects

    # Get a single Shot
    def get_shot(id)
      Dribbble::Shot.new @token, html_get("/shots/#{id}")
    end

    # Get authenticated user's shots
    def get_shots(attrs = {})
      Dribbble::Shot.batch_new token, html_get('/user/shots', attrs)
    end
    alias_method :shots, :get_shots

    # Get authenticated user's followees shots
    # Limited to first 600 shots regardless of the pagination
    def get_following_shots(attrs = {})
      Dribbble::Shot.batch_new token, html_get('/user/following/shots', attrs)
    end
    alias_method :following_shots, :get_following_shots

    # Get authenticated user's teams
    def get_teams(attrs = {})
      Dribbble::Team.batch_new token, html_get('/user/teams', attrs)
    end
    alias_method :teams, :get_teams

    # Get a single User or the authenticated one
    def get_user(id = nil)
      if id
        Dribbble::User.new @token, html_get("/users/#{id}")
      else
        Dribbble::User.new @token, html_get('/user')
      end
    end
    alias_method :user, :get_user

    private

    def build_dribbble_url(id, dribbble_url)
      if dribbble_url.end_with?(id)
        dribbble_url
      else
        "#{dribbble_url}/#{id}"
      end
    end
  end
end
