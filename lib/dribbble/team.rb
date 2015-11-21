module Dribbble
  class Team < Dribbble::Base
    has_many :members, as: Dribbble::User
    has_many :shots
  end
end
