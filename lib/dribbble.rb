module Dribbble
  API_URI = ENV.fetch('DRIBBBLE_API_URI', 'https://api.dribbble.com/v2')
end

require 'dribbble/client'
require 'dribbble/version'
