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
  end
end
