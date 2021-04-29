# frozen_string_literal: true

require 'dribbble/utils/findable'
require 'dribbble/utils/creatable'
require 'dribbble/utils/updatable'
require 'dribbble/utils/deletable'

module Dribbble
  class Bucket < Dribbble::Base
    include Dribbble::Utils::Findable
    include Dribbble::Utils::Creatable
    include Dribbble::Utils::Updatable
    include Dribbble::Utils::Deletable

    has_many :shots

    def add_shot(shot)
      shot_id = shot.is_a?(Dribbble::Shot) ? shot.id : shot
      res = html_put("/buckets/#{id}/shots") do |payload|
        payload[:shot_id] = shot_id
      end
      res.code == 204
    end

    def remove_shot(shot)
      shot_id = shot.is_a?(Dribbble::Shot) ? shot.id : shot
      res = html_delete "/buckets/#{id}/shots", shot_id: shot_id
      res.code == 204
    end

    def self.available_fields
      %i[name description]
    end
  end
end
