require 'spec_helper'

RAW_BUCKET = data_from_json 'bucket_success.json'

describe Dribbble::Bucket do
  before :all do
    @bucket = Dribbble::Bucket.new 'valid_token', RAW_BUCKET
  end

  describe 'after initialization' do
    RAW_BUCKET.each do |field, value|
      it "respond to #{field}" do
        expect(@bucket.send field).to eq(value)
      end
    end
  end

  describe 'on #find' do
    subject do
      stub_dribbble :get, '/buckets/2754', DribbbleAPI::BucketSuccess
      Dribbble::Bucket.find 'valid_token', 2754
    end

    it 'return a bucket' do
      expect(subject).to be_a Dribbble::Bucket
      expect(subject.id).to eq(2754)
    end
  end

  describe 'on #shots' do
    subject do
      stub_dribbble :get, '/bucket/2754/shots', DribbbleAPI::ShotsSuccess
      @bucket.shots
    end

    it 'responds with shots' do
      expect(subject.size).to eq 2
      expect(subject.first).to be_a Dribbble::Shot
    end
  end
end
