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

  describe 'on #get_shot' do
    subject do
      stub_dribbble_with DribbbleAPI::ShotSuccess
      @base.get_shot 471756
    end

    it 'return a shot' do
      expect(subject).to be_a Dribbble::Shot
      expect(subject.id).to eq(471756)
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
        expect(subject.id).to eq(8008135)
      end
    end

    describe 'with id' do
      subject do
        stub_dribbble_with DribbbleAPI::UserSuccess
        @base.get_user 483195
      end

      it 'return current user' do
        expect(subject).to be_a Dribbble::User
        expect(subject.id).to eq(483195)
      end
    end
  end
end
