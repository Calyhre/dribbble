# frozen_string_literal: true

require 'dribbble/utils/findable'
require 'dribbble/utils/creatable'
require 'dribbble/utils/updatable'
require 'dribbble/utils/deletable'

module Dribbble
  class Shot < Dribbble::Base
    include Dribbble::Utils::Findable
    include Dribbble::Utils::Creatable
    include Dribbble::Utils::Updatable
    include Dribbble::Utils::Deletable

    def self.available_fields
      %i[image title description low_profile rebound_source_id scheduled_for tags team_id]
    end

    def self.after_create(res)
      res.code == 202 ? res.headers[:location].split('/').last : false
    end
  end
end
