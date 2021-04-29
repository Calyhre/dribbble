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
        expect(subject.id).to eq(8_008_135)
      end
    end
  end

  describe 'on #buckets' do
    subject do
      stub_dribbble :get, '/user/buckets', DribbbleAPI::BucketsSuccess
      @client.buckets
    end

    it 'return buckets' do
      expect(subject.first).to be_a Dribbble::Bucket
    end
  end

  describe 'on #followers' do
    subject do
      stub_dribbble :get, '/user/followers', DribbbleAPI::FollowersSuccess
      @client.followers
    end

    it 'return users' do
      expect(subject.first).to be_a Dribbble::User
    end
  end

  describe 'on #likes' do
    subject do
      stub_dribbble :get, '/user/likes', DribbbleAPI::UserLikesSuccess
      @client.likes
    end

    it 'return shots' do
      expect(subject.first).to be_a Dribbble::Shot
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

  describe 'on #following_shots' do
    subject do
      stub_dribbble :get, '/user/following/shots', DribbbleAPI::ShotsSuccess
      @client.following_shots
    end

    it 'return shots' do
      expect(subject.first).to be_a Dribbble::Shot
    end
  end

  describe 'on #teams' do
    subject do
      stub_dribbble :get, '/user/teams', DribbbleAPI::TeamsSuccess
      @client.teams
    end

    it 'return teams' do
      expect(subject.first).to be_a Dribbble::Team
    end
  end
end
