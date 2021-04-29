# frozen_string_literal: true

module Dribbble
  module Utils
    module Creatable
      module ClassMethods
        def create(token, attrs)
          @token = token
          res = html_post "/#{api_endpoint}" do |payload|
            available_fields.each { |f| payload[f] = attrs[f] }
          end
          after_create(res)
        end

        # Need to be override if pluralize isn't that naive
        def api_endpoint
          "#{name.split('::').last.downcase}s"
        end

        # Need to be redeclared in the model
        def available_fields
          raise 'You need to redeclare this methods in your model'
        end

        def after_create(res)
          new @token, res
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
