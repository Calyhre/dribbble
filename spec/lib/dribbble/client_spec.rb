require 'spec_helper'

describe Dribbble::Client do
  describe 'without token' do
    it 'raises Dribbble::Error::MissingToken' do
      expect do
        Dribbble::Client.new
      end.to raise_error(Dribbble::Error::MissingToken)
    end
  end

  describe 'on #user' do
    describe 'with an invalid token' do
      subject do
        stub_dribbble :get, '/user', DribbbleAPI::Unauthorized
        Dribbble::Client.new(token: 'fake_invalid_token')
      end

      it 'raise Dribbble::Error::Unauthorized' do
        expect do
          subject.get_user
        end.to raise_error(Dribbble::Error::Unauthorized)
      end
    end

    describe 'with a valid token' do
      subject do
        stub_dribbble :get, '/user', DribbbleAPI::UserSuccess
        Dribbble::Client.new(token: 'valid_token')
      end

      it 'return a Dribbble::User' do
        expect(subject.get_user).to be_a Dribbble::User
        expect(subject.get_user.name).to be_a String
      end
    end
  end
end
