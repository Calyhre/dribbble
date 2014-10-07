require 'spec_helper'

RAW_PROJECT = data_from_json 'project_success.json'

describe Dribbble::Shot do
  before :all do
    @project = Dribbble::Bucket.new 'valid_token', RAW_PROJECT
  end

  describe 'after initialization' do
    RAW_PROJECT.each do |field, value|
      it "respond to #{field}" do
        expect(@project.send field).to eq(value)
      end
    end
  end

  describe 'on #find' do
    subject do
      stub_dribbble_with DribbbleAPI::ProjectSuccess
      Dribbble::Project.find 'valid_token', 3
    end

    it 'return a project' do
      expect(subject).to be_a Dribbble::Project
      expect(subject.id).to eq(3)
    end
  end
end
