require 'spec_helper'

describe Dribbble::Client do
  before :all do
    @base = Dribbble::Base.new 'valid_token', {}
  end

  describe 'on #full_url' do
    describe 'without params' do
      subject { @base.full_url '/shots' }

      it 'return a valid url' do
        expect(subject).to eq('https://api.dribbble.com/v1/shots?page=1&per_page=100')
      end
    end

    describe 'with default params overrided' do
      subject { @base.full_url '/shots', page: 2, per_page: 10 }

      it 'return a valid url' do
        expect(subject).to eq('https://api.dribbble.com/v1/shots?page=2&per_page=10')
      end
    end

    describe 'with extra params' do
      subject { @base.full_url '/shots', params1: 'custom' }

      it 'return a valid url' do
        expect(subject).to eq('https://api.dribbble.com/v1/shots?page=1&per_page=100&params1=custom')
      end
    end
  end

  describe 'on #get_bucket' do
    subject do
      stub_dribbble_with DribbbleAPI::BucketSuccess
      @base.get_bucket 2754
    end

    it 'return a bucket' do
      expect(subject).to be_a Dribbble::Bucket
      expect(subject.id).to eq(2754)
    end
  end

  describe 'on #get_buckets' do
    subject do
      stub_dribbble_with DribbbleAPI::BucketsSuccess
      @base.get_buckets
    end

    it 'return buckets' do
      expect(subject.first).to be_a Dribbble::Bucket
    end
  end

  describe 'on #get_followers' do
    subject do
      stub_dribbble_with DribbbleAPI::FollowersSuccess
      @base.get_followers
    end

    it 'return users' do
      expect(subject.first).to be_a Dribbble::User
    end
  end

  describe 'on #get_likes' do
    subject do
      stub_dribbble_with DribbbleAPI::LikesSuccess
      @base.get_likes
    end

    it 'return shots' do
      expect(subject.first).to be_a Dribbble::Shot
    end
  end

  describe 'on #get_project' do
    subject do
      stub_dribbble_with DribbbleAPI::ProjectSuccess
      @base.get_project 3
    end

    it 'return a project' do
      expect(subject).to be_a Dribbble::Project
      expect(subject.id).to eq(3)
    end
  end

  describe 'on #get_projects' do
    subject do
      stub_dribbble_with DribbbleAPI::ProjectsSuccess
      @base.get_projects
    end

    it 'return projects' do
      expect(subject.first).to be_a Dribbble::Project
    end
  end

  describe 'on #get_shot' do
    subject do
      stub_dribbble_with DribbbleAPI::ShotSuccess
      @base.get_shot 471_756
    end

    it 'return a shot' do
      expect(subject).to be_a Dribbble::Shot
      expect(subject.id).to eq(471_756)
    end
  end

  describe 'on #get_shots' do
    subject do
      stub_dribbble_with DribbbleAPI::ShotsSuccess
      @base.get_shots
    end

    it 'return shots' do
      expect(subject.first).to be_a Dribbble::Shot
    end
  end

  describe 'on #get_teams' do
    subject do
      stub_dribbble_with DribbbleAPI::TeamsSuccess
      @base.get_teams
    end

    it 'return teams' do
      expect(subject.first).to be_a Dribbble::Team
    end
  end

  describe 'on #get_user' do
    describe 'without id' do
      subject do
        stub_dribbble_with DribbbleAPI::CurrentUserSuccess
        @base.get_user
      end

      it 'return current user' do
        expect(subject).to be_a Dribbble::User
        expect(subject.id).to eq(8_008_135)
      end
    end

    describe 'with id' do
      subject do
        stub_dribbble_with DribbbleAPI::UserSuccess
        @base.get_user 483_195
      end

      it 'return current user' do
        expect(subject).to be_a Dribbble::User
        expect(subject.id).to eq(483_195)
      end
    end
  end
end
