# frozen_string_literal: true

module Dribbble
  module Error
    ISSUES_URL = 'https://github.com/Calyhre/dribbble/issues/new'

    # Standard error we will inherit
    class Standard < StandardError
      def initialize(message = nil)
        if message&.response
          super message.response
        else
          super(message || self.message)
        end
      end
    end

    class MissingToken < Standard
    end

    class Unauthorized < Standard
    end

    class Unprocessable < Standard
    end
  end
end
