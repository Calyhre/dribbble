module Dribbble
  module Utils
    module Creatable
      def create(token, attrs)
        @token = token
        res = post "/#{pluralize_name}" do |payload|
          available_fields.each { |f| payload[f] = attrs[f] }
        end
        after_create(res)
      end

      # Need to be override if pluralize isn't that naive
      def pluralize_name
        "#{name.split('::').last.downcase}s"
      end

      # Need to be redeclared in the model
      def available_fields
        fail "You need to redeclare this methods in your model"
      end

      def after_create(res)
        new @token, res
      end
    end
  end
end
