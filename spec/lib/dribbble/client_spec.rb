# frozen_string_literal: true

require 'spec_helper'

describe Dribbble::Client do
  before do
    @client = described_class.new 'valid_token'
  end

  describe 'without token' do
    it 'raises Dribbble::Error::MissingToken' do
      expect do
        described_class.new
      end.to raise_error(Dribbble::Error::MissingToken)
    end
  end

  describe 'on #user' do
    describe 'with an invalid token' do
      subject do
        stub_dribbble :get, '/user', DribbbleAPI::Unauthorized
        described_class.new(token: 'fake_invalid_token')
      end

      it 'raise Dribbble::Error::Unauthorized' do
        expect do
          subject.user
        end.to raise_error(Dribbble::Error::Unauthorized)
      end
    end

    describe 'with a valid token' do
      subject do
        stub_dribbble :get, '/user', DribbbleAPI::UserSuccess
        described_class.new(token: 'valid_token')
      end

      it 'return a Dribbble::User' do
        expect(subject.user).to be_a Dribbble::User
        expect(subject.user.name).to be_a String
      end
    end

    describe 'with current user' do
      subject do
        stub_dribbble :get, '/user', DribbbleAPI::CurrentUserSuccess
        @client.user
      end

      it 'return current user' do
        expect(subject).to be_a Dribbble::User
        expect(subject.id).to eq(1)
      end
    end
  end

  describe 'on #projects' do
    subject do
      stub_dribbble :get, '/user/projects', DribbbleAPI::ProjectsSuccess
      @client.projects
    end

    it 'return projects' do
      expect(subject.first).to be_a Dribbble::Project
    end
  end

  describe 'on #shots' do
    subject do
      stub_dribbble :get, '/user/shots', DribbbleAPI::ShotsSuccess
      @client.shots
    end

    it 'return shots' do
      expect(subject.first).to be_a Dribbble::Shot
    end
  end
end
