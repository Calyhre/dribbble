module Dribbble
  class Project < Dribbble::Base
    def self.find(token, id)
      super
      @client.get_project(id)
    end
  end
end
