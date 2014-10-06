require 'uri'

module Dribbble
  module Utils
    DEFAULT_ATTRIBUTES = {
      page: 1,
      per_page: 100
    }

    def full_url(path, attrs = {})
      query = URI.encode_www_form DEFAULT_ATTRIBUTES.merge(attrs)
      "#{Dribbble::API_URI}#{path}?#{query}"
    end

    def headers
      if @token
        { authorization: "Bearer #{@token}" }
      else
        {}
      end
    end

    def get(path, attrs = {})
      RestClient.get full_url(path, attrs), headers
    rescue RestClient::Unauthorized => e
      raise Dribbble::Error::Unauthorized, e
    end

    def post(path, attrs = {})
      payload = {}
      yield payload
      RestClient.post full_url(path, attrs), payload, headers
    rescue RestClient::Unauthorized => e
      raise Dribbble::Error::Unauthorized, e
    rescue RestClient::UnprocessableEntity => e
      raise Dribbble::Error::Unprocessable, e
    end
  end
end
