module Dribbble
  class Like < Dribbble::Base
    def user
      @user ||= Dribbble::User.new token, @raw['user']
    end
  end
end
