require 'spec_helper'

RAW_SHOT = data_from_json 'shot_success.json'

describe Dribbble::Shot do
  before :all do
    @shot = Dribbble::Shot.new 'valid_token', RAW_SHOT
  end

  describe 'after initialization' do
    RAW_SHOT.each do |field, value|
      it "respond to #{field}" do
        expect(@shot.send field).to eq(value)
      end
    end
  end

  describe 'on #attachments' do
    subject do
      stub_dribbble_with DribbbleAPI::AttachmentsSuccess
      @shot.attachments
    end

    it 'return a shot' do
      expect(subject.first).to be_a Dribbble::Attachment
    end
  end

  describe 'on #buckets' do
    subject do
      stub_dribbble_with DribbbleAPI::BucketsSuccess
      @shot.buckets
    end

    it 'return a shot' do
      expect(subject.first).to be_a Dribbble::Bucket
    end
  end

  describe 'on #comments' do
    subject do
      stub_dribbble_with DribbbleAPI::CommentsSuccess
      @shot.comments
    end

    it 'return a shot' do
      expect(subject.first).to be_a Dribbble::Comment
    end
  end

  describe 'on #likes' do
    subject do
      stub_dribbble_with DribbbleAPI::ShotLikesSuccess
      @shot.likes
    end

    it 'return a user' do
      expect(subject.first).to be_a Dribbble::User
    end
  end

  describe 'on #find' do
    subject do
      stub_dribbble_with DribbbleAPI::ShotSuccess
      Dribbble::Shot.find 'valid_token', 471_756
    end

    it 'return a shot' do
      expect(subject).to be_a Dribbble::Shot
      expect(subject.id).to eq(471_756)
    end
  end

  describe 'on #all' do
    subject do
      stub_dribbble_with DribbbleAPI::ShotsSuccess
      Dribbble::Shot.all 'valid_token'
    end

    it 'return a shot' do
      expect(subject.first).to be_a Dribbble::Shot
    end
  end
end
