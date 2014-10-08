require 'spec_helper'

RAW_USER = data_from_json 'user_success.json'

describe Dribbble::User do
  before :all do
    @user = Dribbble::User.new 'valid_token', RAW_USER
  end

  describe 'after initialization' do
    RAW_USER.each do |field, value|
      it "respond to #{field}" do
        expect(@user.send field).to eq(value)
      end
    end
  end

  describe 'on #find' do
    subject do
      stub_dribbble_with DribbbleAPI::UserSuccess
      Dribbble::User.find 'valid_token', 483_195
    end

    it 'return a user' do
      expect(subject).to be_a Dribbble::User
      expect(subject.id).to eq(483_195)
    end
  end

  describe 'on #buckets' do
    subject do
      stub_dribbble_with DribbbleAPI::BucketsSuccess
      @user.buckets
    end

    it 'responds with buckets' do
      expect(subject.size).to eq 1
      expect(subject.first).to be_a Dribbble::Bucket
    end
  end

  describe '#followers' do
    subject do
      stub_dribbble_with DribbbleAPI::FollowersSuccess
      @user.followers
    end

    it 'responds with users' do
      expect(subject.size).to eq 1
      expect(subject.first).to be_a Dribbble::User
    end
  end

  describe '#likes' do
    subject do
      stub_dribbble_with DribbbleAPI::UserLikesSuccess
      @user.likes
    end

    it 'responds with shots' do
      expect(subject.size).to eq 1
      expect(subject.first).to be_a Dribbble::Shot
    end
  end

  describe '#projects' do
    subject do
      stub_dribbble_with DribbbleAPI::ProjectsSuccess
      @user.projects
    end

    it 'responds with projects' do
      expect(subject.size).to eq 1
      expect(subject.first).to be_a Dribbble::Project
    end
  end

  describe '#shots' do
    subject do
      stub_dribbble_with DribbbleAPI::ShotsSuccess
      @user.shots
    end

    it 'responds with buckets' do
      expect(subject.size).to eq 2
      expect(subject.first).to be_a Dribbble::Shot
    end
  end

  describe '#teams' do
    subject do
      stub_dribbble_with DribbbleAPI::TeamsSuccess
      @user.teams
    end

    it 'responds with teams' do
      expect(subject.size).to eq 1
      expect(subject.first).to be_a Dribbble::Team
    end
  end
end
