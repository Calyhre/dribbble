module Dribbble
  module Utils
    module Deletable
      def delete
        res = html_delete "/#{self.class.pluralize_name}/#{id}"
        res.code == 204 ? true : false
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
