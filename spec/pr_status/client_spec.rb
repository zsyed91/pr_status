require 'spec_helper'

describe PrStatus::Client do
  let(:credentials) do
    { access_token: YAML.load_file('config/secrets.yml')['access_token'] }
  end
  let(:client) { PrStatus::Client.new(credentials) }

  describe '#instantiate' do
    it 'should instantiate the octokit wrapper' do
      expect { PrStatus::Client.new(credentials) }.not_to raise_error
    end
  end

  describe '#pull_requests' do
    context 'no filters' do
      it 'should return the count of pull requests' do
        expect(client.pull_requests).to be >= 0
      end
    end
  end
end
