module Dribbble
  class User
    attr_reader :raw

    def initialize(json)
      @raw = json
    end

    def method_missing(method, *args, &block)
      if @raw.key? method.to_s
        @raw[method.to_s]
      else
        super
      end
    end
  end
end
