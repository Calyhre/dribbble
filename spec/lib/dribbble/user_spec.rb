# frozen_string_literal: true

require 'spec_helper'

RAW_USER = data_from_json 'user_success.json'

describe Dribbble::User do
  describe 'on instance' do
    before do
      @user = described_class.new 'valid_token', RAW_USER
    end

    describe 'after initialization' do
      RAW_USER.each do |field, value|
        it "respond to #{field}" do
          expect(@user.send(field)).to eq(value)
        end
      end
    end
  end
end
