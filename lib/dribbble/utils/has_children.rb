module Dribbble
  module Utils
    module HasChildren
      module ClassMethods
        def has_many(*fields)
          if fields[1].is_a? Hash
            generate_methods fields[0], fields[1][:as]
          else
            fields.each do |field|
              generate_methods field
            end
          end
        end

        def generate_methods(field, klass = nil)
          singularized_field = field[0...-1]

          define_method field do |attrs = {}|
            klass ||= Object.const_get "Dribbble::#{__method__[0...-1].capitalize}"
            klass.batch_new token, html_get("/#{pluralized_class_name}/#{id}/#{klass.pluralized_class_name}", attrs)
          end

          define_method "find_#{singularized_field}" do |child_id|
            klass ||= Object.const_get "Dribbble::#{__method__[0...-1].capitalize}"
            klass.new token, html_get("/#{pluralized_class_name}/#{id}/#{klass.pluralized_class_name}/#{child_id}")
          end

          define_method "create_#{singularized_field}" do |attrs = {}|
            klass ||= Object.const_get "Dribbble::#{__method__[0...-1].capitalize}"
            res = html_post "/#{pluralized_class_name}/#{id}/#{klass.pluralized_class_name}" do |payload|
              klass.available_fields.each do |field|
                payload[field] = attrs[field]
              end
            end
            res.code == 202 ? true : false
          end

          define_method "delete_#{singularized_field}" do |child_id|
            klass ||= Object.const_get "Dribbble::#{__method__[0...-1].capitalize}"
            res = html_delete "/#{pluralized_class_name}/#{id}/#{klass.pluralized_class_name}/#{child_id}"
            res.code == 204 ? true : false
          end
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
