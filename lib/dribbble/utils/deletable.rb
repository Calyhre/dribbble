# frozen_string_literal: true

module Dribbble
  module Utils
    module Deletable
      def delete
        res = html_delete "/#{self.class.api_endpoint}/#{id}"
        res.code == 204 || res.code == 200
      end

      module ClassMethods
        def delete(token, id)
          object = find token, id
          object.delete
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
