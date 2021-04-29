# frozen_string_literal: true

module Dribbble
  module Utils
    module Findable
      module ClassMethods
        def find(token, id)
          @token = token
          new token, html_get("/#{pluralized_class_name}/#{id}")
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
