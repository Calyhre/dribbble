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

    def self.batch_new(token, json)
      json = JSON.parse json unless json.is_a? Hash
      json.map do |obj|
        new token, obj
      end
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
