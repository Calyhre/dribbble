# frozen_string_literal: true

module Dribbble
  module Utils
    module HasChildren
      module ClassMethods
        def has_many(*fields) # rubocop:disable Naming/PredicateName
          if fields[1].is_a? Hash
            generate_methods fields[0], fields[1][:as], fields[1][:key]
          else
            fields.each do |field|
              generate_methods field
            end
          end
        end

        # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
        def generate_methods(field, klass = nil, key = nil)
          singularized_field = field[0...-1]

          define_method field do |attrs = {}|
            klass ||= Object.const_get "Dribbble::#{singularized_field.capitalize}"
            url = "/#{pluralized_class_name}/#{id}/#{field}"
            klass.batch_new token, html_get(url, attrs), key, url
          end

          define_method "find_#{singularized_field}" do |child_id|
            klass ||= Object.const_get "Dribbble::#{singularized_field.capitalize}"
            url = "/#{pluralized_class_name}/#{id}/#{field}/#{child_id}"
            klass.new token, html_get(url), url
          end

          define_method "create_#{singularized_field}" do |attrs = {}|
            klass ||= Object.const_get "Dribbble::#{singularized_field.capitalize}"
            url = "/#{pluralized_class_name}/#{id}/#{field}"
            res = html_post url do |payload|
              klass.available_fields.each do |available_field|
                payload[available_field] = attrs[available_field]
              end
            end
            case res.code
            when 202
              return true
            when 201
              return klass.new token, res, url
            else
              return false
            end
          end

          define_method "update_#{singularized_field}" do |child_id, attrs = {}|
            klass ||= Object.const_get "Dribbble::#{__method__[0...-1].capitalize}"
            url = "/#{pluralized_class_name}/#{id}/#{klass.pluralized_class_name}/#{child_id}"
            res = html_put url do |payload|
              klass.available_fields.each do |available_field|
                payload[available_field] = attrs[available_field]
              end
            end
            klass.new token, res, url
          end

          define_method "delete_#{singularized_field}" do |child_id|
            klass ||= Object.const_get "Dribbble::#{__method__[0...-1].capitalize}"
            res = html_delete "/#{pluralized_class_name}/#{id}/#{klass.pluralized_class_name}/#{child_id}"
            res.code == 204
          end
        end
      end
      # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
