module Dribbble
  module Utils
    module HasChildren
      module ClassMethods
        def has_many(*fields)
          if fields[1].is_a? Hash
            field = fields[0]
            singularized_field = field[0...-1]
            klass = fields[1][:as]

            define_method field do |attrs = {}|
              klass.batch_new token, html_get("/#{pluralized_class_name}/#{id}/#{klass.pluralized_class_name}", attrs)
            end
          else
            fields.each do |field|
              cheat = field

              define_method cheat do |attrs = {}|
                singularized_field = cheat[0...-1]
                klass = Object.const_get "Dribbble::#{singularized_field.capitalize}"
                klass.batch_new token, html_get("/#{pluralized_class_name}/#{id}/#{klass.pluralized_class_name}", attrs)
              end
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
