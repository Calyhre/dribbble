# frozen_string_literal: true

require 'spec_helper'

RAW_TEAM = data_from_json 'team_success.json'

describe Dribbble::Team do
  describe 'on instance' do
    before do
      @team = described_class.new 'valid_token', RAW_TEAM, '/teams/39'
    end

    describe 'after initialization' do
      RAW_TEAM.each do |field, value|
        it "respond to #{field}" do
          expect(@team.send(field)).to eq(value)
        end
      end
    end

    describe 'on #shots' do
      subject do
        stub_dribbble :get, '/teams/39/shots', DribbbleAPI::ShotsSuccess
        @team.shots
      end

      it 'responds with shots' do
        expect(subject.size).to eq 2
        expect(subject.first).to be_a Dribbble::Shot
      end
    end

    describe 'on #members' do
      subject do
        stub_dribbble :get, '/teams/39/members', DribbbleAPI::UsersSuccess
        @team.members
      end

      it 'responds with members' do
        expect(subject.size).to eq 1
        expect(subject.first).to be_a Dribbble::User
      end
    end
  end
end
