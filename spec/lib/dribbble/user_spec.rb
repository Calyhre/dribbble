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
end
