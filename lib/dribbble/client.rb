require 'dribbble/user'
require 'dribbble/errors'

require 'rest_client'
require 'json'

module Dribbble
  class Client
    attr_reader :token

    def initialize(token: nil)
      @token = token

      fail Dribbble::Error::MissingToken if @token.nil?
    end

    def user
      return @user unless @user.nil?

      res = get('/user')
      @user = Dribbble::User.new JSON.parse(res)
    end

    def create_shot(attrs = {})
      fields = %i(title image description tags team_id rebound_source_id)
      post '/shots' do |payload|
        fields.each { |f| payload[f] = attrs[f] }
      end
    end

    # Utils

    def full_url(path)
      "#{Dribbble::API_URI}#{path}"
    end

    def headers
      {
        authorization: "Bearer #{@token}"
      }
    end

    def get(path)
      RestClient.get full_url(path), headers
    rescue RestClient::Unauthorized => e
      raise Dribbble::Error::Unauthorized, e
    end

    def post(path)
      payload = {}
      yield payload
      RestClient.post full_url(path), payload, headers
    rescue RestClient::Unauthorized => e
      raise Dribbble::Error::Unauthorized, e
    rescue RestClient::UnprocessableEntity => e
      raise Dribbble::Error::Unprocessable, e
    end
  end
end
