require 'spec_helper'

RAW_PROJECT = data_from_json 'project_success.json'

describe Dribbble::Project do
  before :all do
    @project = Dribbble::Project.new 'valid_token', RAW_PROJECT
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
      stub_dribbble :get, '/projects/3', DribbbleAPI::ProjectSuccess
      Dribbble::Project.find 'valid_token', 3
    end

    it 'return a project' do
      expect(subject).to be_a Dribbble::Project
      expect(subject.id).to eq(3)
    end
  end

  describe 'on #shots' do
    subject do
      stub_dribbble :get, '/projects/3/shots', DribbbleAPI::ShotsSuccess
      @project.shots
    end

    it 'responds with shots' do
      expect(subject.size).to eq 2
      expect(subject.first).to be_a Dribbble::Shot
    end
  end
end
