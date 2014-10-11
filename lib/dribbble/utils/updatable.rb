module Dribbble
  module Utils
    module Updatable
      def update(attrs)
        res = html_put "/#{self.class.pluralize_name}/#{id}" do |payload|
          self.class.available_fields.each { |f| payload[f] = attrs[f] }
        end
        @raw = JSON.parse res
        self
      end

      module ClassMethods
        def update(token, id, attrs)
          object = find token, id
          object.update attrs
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
