# frozen_string_literal: true

require 'dribbble'
require 'webmock/rspec'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

# WebMock.disable_net_connect! allow_localhost: true, allow: 'codeclimate.com'

RSpec.configure do |config|
  config.before do
    WebMock.reset!
  end
end

def stub_dribbble(method, path, response_class)
  url = %r{api.dribbble.com/v2#{Regexp.escape path}(\?.*)?$}
  stub_request(method, url).to_rack(response_class)
end

def data_from_json(json_name)
  file_name = "#{File.dirname(__FILE__)}/support/fixtures/#{json_name}"
  JSON.parse File.open(file_name, 'rb').read
end
