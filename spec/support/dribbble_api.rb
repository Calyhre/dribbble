# frozen_string_literal: true

require 'sinatra/base'

class String
  def underscore
    gsub(/::/, '/')
      .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
      .tr('-', '_')
      .downcase
  end
end

module DribbbleAPI
  class Base < Sinatra::Base
    get '/*' do
      json_response
    end

    post '/*' do
      json_response
    end

    put '/*' do
      json_response
    end

    delete '/*' do
      json_response
    end

    protected

    def json_file_name
      @json_file_name ||= self.class.name.split('::').last.underscore
    end

    def json_response
      content_type :json
      status status_code
      headers response_headers
      file_name = "#{File.dirname(__FILE__)}/fixtures/#{json_file_name}.json"

      return {}.to_json unless File.exist? file_name

      File.open(file_name, 'rb')
    end

    def response_headers
      {}
    end
  end

  class Found < Base
    def status_code
      200
    end
  end

  class Updated < Found
  end

  class Created < Base
    def status_code
      201
    end
  end

  class Accepted < Base
    def status_code
      202
    end
  end

  class Deleted < Base
    def status_code
      204
    end
  end

  class NoContent < Deleted
  end

  class NotFound < Base
    def status_code
      404
    end
  end

  class Unauthorized < Base
    def status_code
      401
    end
  end

  class Unprocessable < Base
    def status_code
      422
    end

    protected

    def json_response
      content_type :json
      status status_code
      headers response_headers

      {
        message: 'Validation failed.',
        errors: [
          { attribute: 'user', message: 'reached the daily limit of 5 shots' }
        ]
      }.to_json
    end
  end

  class AttachmentsSuccess < Found
  end

  class AttachmentSuccess < Found
  end

  class AttachmentDeleted < Deleted
  end

  class CurrentUserSuccess < Found
  end

  class ProjectSuccess < Found
  end

  # TODO: pending
  class ProjectsSuccess < Found
  end

  class ProjectsAccepted < Found
  end

  class ProjectsDeleted < Found
  end

  class ProjectsUpdated < Found
  end
  # END

  class ShotUpdated < Updated
  end

  class ShotDeleted < Deleted
  end

  class ShotSuccess < Found
  end

  class ShotAccepted < Accepted
    def response_headers
      {
        'Location' => 'https://api.dribbble.com/v2/shots/471756'
      }
    end
  end

  class ShotsSuccess < Found
  end

  class UserSuccess < Found
  end

  class UsersSuccess < Found
  end
end
