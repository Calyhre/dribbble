module Dribbble
  module Utils
    def full_url(path)
      "#{Dribbble::API_URI}#{path}"
    end

    def headers
      if @token
        { authorization: "Bearer #{@token}" }
      else
        {}
      end
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
