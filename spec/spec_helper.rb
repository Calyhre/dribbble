require 'spork'

Spork.prefork do
  require 'dribbble'
  require 'webmock/rspec'
  require 'faker'
  require 'factory_girl'

  Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

  # WebMock.disable_net_connect! allow_localhost: true, allow: 'codeclimate.com'

  def stub_dribbble_with(response_class)
    stub_request(:any, /api\.dribbble\.com/).to_rack(response_class)
  end

  def data_from_json(json_name)
    JSON.parse File.open(File.dirname(__FILE__) + "/support/fixtures/#{json_name}", 'rb').read
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

end
