# frozen_string_literal: true

require 'spec_helper'

RAW_PROJECT = data_from_json 'project_success.json'

describe Dribbble::Project do
  describe 'on instance' do
    before do
      @project = described_class.new 'valid_token', RAW_PROJECT
    end

    describe 'after initialization' do
      RAW_PROJECT.each do |field, value|
        it "respond to #{field}" do
          expect(@project.send(field)).to eq(value)
        end
      end
    end
  end

  describe 'on class' do
    describe 'on #find' do
      subject do
        stub_dribbble :get, '/projects/3', DribbbleAPI::ProjectSuccess
        described_class.find 'valid_token', 3
      end

      it 'return a shot' do
        expect(subject).to be_a described_class
        expect(subject.id).to eq(3)
      end
    end

    describe 'on #create' do
      subject do
        stub_dribbble :post, '/projects', DribbbleAPI::ProjectsAccepted
        data = {
          name: 'Project title',
          desciption: 'Project description'
        }
        described_class.create 'valid_token', data
      end

      it 'create the project' do
        expect(subject).to be_truthy
        expect(subject.id).to eq(3)
        expect(subject.name).to eq('Project title')
        expect(subject.description).to eq('Project description')
      end
    end

    describe 'on #delete' do
      subject do
        stub_dribbble :get, '/projects/3', DribbbleAPI::ProjectSuccess
        stub_dribbble :delete, '/projects/3', DribbbleAPI::ProjectsDeleted
        described_class.delete 'valid_token', 3
      end

      it 'return true' do
        expect(subject).to eq(true)
      end
    end

    describe 'on #update' do
      subject do
        stub_dribbble :get, '/projects/3', DribbbleAPI::ProjectSuccess
        stub_dribbble :put, '/projects/3', DribbbleAPI::ProjectsUpdated
        data = {
          name: 'Project title',
          description: 'Project description'
        }
        described_class.update 'valid_token', 3, data
      end

      it 'update data' do
        expect(subject.name).to eq('Project title')
      end
    end
  end
end
