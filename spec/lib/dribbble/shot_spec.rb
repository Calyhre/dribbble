require 'spec_helper'

RAW_SHOT = data_from_json 'shot_success.json'

describe Dribbble::Shot do
  before :all do
    @shot = Dribbble::Bucket.new 'valid_token', RAW_SHOT
  end

  describe 'after initialization' do
    RAW_SHOT.each do |field, value|
      it "respond to #{field}" do
        expect(@shot.send field).to eq(value)
      end
    end
  end

  describe 'on #find' do
    subject do
      stub_dribbble_with DribbbleAPI::ShotSuccess
      Dribbble::Shot.find 'valid_token', 471756
    end

    it 'return a shot' do
      expect(subject).to be_a Dribbble::Shot
      expect(subject.id).to eq(471756)
    end
  end
end
