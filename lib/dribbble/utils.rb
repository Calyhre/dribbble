require 'uri'

module Dribbble
  module Utils
    DEFAULT_ATTRIBUTES = {
      page: 1,
      per_page: 100
    }

    def full_url(path, attrs = {})
      "#{Dribbble::API_URI}#{path}?#{URI.encode_www_form attrs}"
    end

    def full_url_with_default_params(path, attrs = {})
      full_url path, DEFAULT_ATTRIBUTES.merge(attrs)
    end

    def headers
      if @token
        { authorization: "Bearer #{@token}" }
      else
        {}
      end
    end

    def html_get(path, attrs = {})
      res = RestClient.get full_url_with_default_params(path, attrs), headers
      res.force_encoding('UTF-8')
    rescue RestClient::Unauthorized => e
      raise Dribbble::Error::Unauthorized, e
    end

    def html_post(path, attrs = {})
      payload = {}
      yield payload if block_given?
      res = RestClient.post full_url(path, attrs), payload, headers
      res.force_encoding('UTF-8')
    rescue RestClient::Unauthorized => e
      raise Dribbble::Error::Unauthorized, e
    rescue RestClient::UnprocessableEntity => e
      raise Dribbble::Error::Unprocessable, e
    end

    def html_put(path, attrs = {})
      payload = {}
      yield payload if block_given?
      res = RestClient.put full_url(path, attrs), payload, headers
      res.force_encoding('UTF-8')
    rescue RestClient::Unauthorized => e
      raise Dribbble::Error::Unauthorized, e
    rescue RestClient::UnprocessableEntity => e
      raise Dribbble::Error::Unprocessable, e
    end

    def html_delete(path, attrs = {})
      res = RestClient.delete full_url(path, attrs), headers
      res.force_encoding('UTF-8')
    rescue RestClient::Unauthorized => e
      raise Dribbble::Error::Unauthorized, e
    end
  end
end
