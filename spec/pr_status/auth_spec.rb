require 'spec_helper'
require 'yaml'

describe PrStatus::Auth do
  let(:access_token) { YAML.load_file('config/secrets.yml')['access_token'] }
  let(:invalid_access_token) { '2short' }
  let(:auth) { PrStatus::Auth.new(access_token: access_token) }

  describe '#initialize' do
    context 'given invalid input' do
      it 'should raise an error if credentials is not hash' do
        expect { PrStatus::Auth.new }.to raise_error(ArgumentError)
        expect { PrStatus::Auth.new([]) }.to(
          raise_error(ArgumentError, 'Need to pass in credentials hash'))
      end
    end

    context 'given access_token' do
      it 'should raise an error if invalid format' do
        expect { PrStatus::Auth.new(access_token: invalid_access_token) }.to(
          raise_error(ArgumentError, 'Invalid Auth Token'))
      end

      it 'should not raise an error if valid format' do
        expect { PrStatus::Auth.new(access_token: access_token) }.not_to(
          raise_error)
      end
    end

    context 'given username/password' do
      it 'should raise an error if missing password' do
        expect { PrStatus::Auth.new(login: 'user') }.to(
          raise_error(ArgumentError, 'Password missing'))
      end

      it 'should raise an error if missing username' do
        expect { PrStatus::Auth.new(password: '123') }.to(
          raise_error(ArgumentError, 'Username (:login) missing'))
      end
    end
  end

  describe '#authenticate' do
    context 'given a valid credentials' do
      it 'should return the client' do
        expect(auth.authenticate).to be_a(PrStatus::Client)
      end
    end
  end
end
