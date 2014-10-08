module Dribbble
  module Utils
    module Findable
      def find(token, id)
        @token = token
        @client = Dribbble::Client.new token: @token
        @client.send "get_#{name.split('::').last.downcase}", id
      end
    end
  end
end
