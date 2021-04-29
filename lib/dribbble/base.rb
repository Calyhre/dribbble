# frozen_string_literal: true

require 'dribbble/utils'
require 'dribbble/utils/has_children'

module Dribbble
  class Base
    include Dribbble::Utils
    extend Dribbble::Utils

    include Dribbble::Utils::HasChildren

    attr_reader :token, :dribbble_url

    def initialize(token, json, dribbble_url = '')
      @token = token

      @raw = json.is_a?(Hash) ? json : JSON.parse(json)
      @dribbble_url = build_dribbble_url(@raw['id'].to_s, dribbble_url)

      @raw.each do |k, _v|
        define_singleton_method(k) { @raw[k] } unless respond_to?(k)
      end
    end

    def self.batch_new(token, json, kind = nil, url = '')
      json = JSON.parse json unless json.is_a? Hash
      json.map do |obj|
        if kind
          new token, obj[kind], url
        else
          new token, obj, url
        end
      end
    end

    private

    def build_dribbble_url(id, dribbble_url)
      if dribbble_url.end_with?(id)
        dribbble_url
      else
        "#{dribbble_url}/#{id}"
      end
    end
  end
end
