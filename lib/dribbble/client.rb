require 'dribbble/base'
require 'dribbble/user'
require 'dribbble/errors'

require 'rest_client'
require 'json'

module Dribbble
  class Client < Dribbble::Base
    include Dribbble::Utils

    def initialize(token: nil)
      @token = token
      fail Dribbble::Error::MissingToken if @token.nil?
    end

    def create_shot(attrs = {})
      fields = %i(title image description tags team_id rebound_source_id)
      res = post '/shots' do |payload|
        fields.each { |f| payload[f] = attrs[f] }
      end
      res.code == 202 ? true : false
    end

    def create_bucket(attrs = {})
      fields = %i(name description)
      res = post '/buckets' do |payload|
        fields.each { |f| payload[f] = attrs[f] }
      end
      Dribbble::Bucket.new @token, res
    end
  end
end
