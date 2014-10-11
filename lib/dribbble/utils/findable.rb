module Dribbble
  module Utils
    module Findable
      module ClassMethods
        def find(token, id)
          @token = token
          @client = Dribbble::Client.new token: @token
          @client.send "get_#{name.split('::').last.downcase}", id
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
