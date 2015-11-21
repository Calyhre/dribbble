require 'dribbble/base'
require 'dribbble/user'
require 'dribbble/bucket'
require 'dribbble/project'
require 'dribbble/shot'
require 'dribbble/team'
require 'dribbble/errors'

require 'rest_client'
require 'json'

module Dribbble
  class Client < Dribbble::Base
    include Dribbble::Utils

    def initialize(token)
      token = token.is_a?(Hash) ? token[:token] : token
      @token = token
      fail Dribbble::Error::MissingToken if @token.nil?
    end
  end
end
