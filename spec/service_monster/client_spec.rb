require 'spec_helper'
require 'webmock/rspec'

RSpec.describe ServiceMonster::Client do

  it 'should connect using the configured endpoint and api version' do
    client = ServiceMonster::Client.new
    endpoint = URI.parse("#{client.endpoint}#{client.api_version}/")
    connection = client.send(:connection).build_url(nil).to_s
    expect(connection).to eq(endpoint.to_s)
  end

  # Test authorization for Kickserv.
  # Test case record the http response in
  # get_auth_error.yml file for offline mode.
  # This test case call http api.
  # Validate fields present in response.
  it 'check authorization error' do
    VCR.use_cassette('authorization_error') do
      client = ServiceMonster.client(api_key: 'API_KEY')
      expect {client.accounts {raise} }.to raise_error('Invalid credentials.')
    end
  end
end


