require 'sinatra/base'

class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
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

    protected

    def json_file_name
      @json_file_name ||= self.class.name.split('::').last.underscore
    end

    def json_response
      content_type :json
      status status_code
      file_name = "#{File.dirname(__FILE__)}/fixtures/#{json_file_name}.json"

      return {}.to_json unless File.exists? file_name

      File.open(file_name, 'rb')
    end
  end

  class Found < Base
    def status_code
      200
    end
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

  class AttachmentsSuccess < Found
  end

  class CommentsSuccess < Found
  end

  class CurrentUserSuccess < Found
  end

  class BucketSuccess < Found
  end

  class BucketCreated < Created
  end

  class BucketsSuccess < Found
  end

  class FollowersSuccess < Found
  end

  class UserLikesSuccess < Found
  end

  class ProjectSuccess < Found
  end

  class ProjectsSuccess < Found
  end

  class ShotSuccess < Found
  end

  class ShotAccepted < Accepted
  end

  class ShotLikesSuccess < Accepted
  end

  class ShotsSuccess < Found
  end

  class TeamsSuccess < Found
  end

  class UserSuccess < Found
  end
end
