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
        define_singleton_method(k) { v }
      end
    end


    def self.find(token, id)
      @token = token
      @client = Dribbble::Client.new token: @token
    end

    def self.batch_new(token, json)
      json = JSON.parse json unless json.is_a? Hash
      json.map do |obj|
        new token, obj
      end
    end

    def get_bucket(id)
      Dribbble::Bucket.new @token, get("/buckets/#{id}")
    end

    def get_project(id)
      Dribbble::Project.new @token, get("/projects/#{id}")
    end

    def get_shot(id)
      Dribbble::Shot.new @token, get("/shots/#{id}")
    end

    def get_user(id = nil)
      if id
        Dribbble::User.new @token, get("/users/#{id}")
      else
        Dribbble::User.new @token, get('/user')
      end
    end
  end
end
