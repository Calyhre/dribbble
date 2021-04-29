# frozen_string_literal: true

require 'dribbble/utils/creatable'
require 'dribbble/utils/deletable'

module Dribbble
  class Attachment < Dribbble::Base
    include Dribbble::Utils::Creatable
    include Dribbble::Utils::Deletable

    def self.available_fields
      %i[file]
    end
  end
end
