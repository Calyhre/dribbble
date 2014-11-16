module Dribbble
  module Utils
    module HasChildren
      module ClassMethods
        def has_many(*fields)
          fields.each do |field|
            singularized_field = field[0...-1]
            klass = Object.const_get "Dribbble::#{singularized_field.capitalize}"

            define_method field do |attrs = {}|
              klass.batch_new token, html_get("/#{pluralized_class_name}/#{id}/#{klass.pluralized_class_name}", attrs)
            end
          end
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
