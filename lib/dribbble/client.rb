# frozen_string_literal: true

require 'dribbble/base'
require 'dribbble/shot'
require 'dribbble/user'
require 'dribbble/project'
require 'dribbble/errors'

require 'rest_client'
require 'json'

module Dribbble
  class Client < Dribbble::Base
    include Dribbble::Utils

    def initialize(token = nil)
      token = token.is_a?(Hash) ? token[:token] : token
      @token = token
      super(token, {})
      raise Dribbble::Error::MissingToken if @token.nil?
    end

    # Get authenticated user's followers
    def projects(attrs = {})
      Dribbble::Project.batch_new token, html_get('/user/projects', attrs)
    end

    # Get authenticated user's shots
    def shots(attrs = {})
      Dribbble::Shot.batch_new token, html_get('/user/shots', attrs)
    end

    # Get a single User or the authenticated one
    def user
      Dribbble::User.new @token, html_get('/user')
    end
  end
end
