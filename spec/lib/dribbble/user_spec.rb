require 'spec_helper'

RAW_USER = data_from_json 'success.json'

describe Dribbble::User do
  before :all do
    @user = Dribbble::User.new RAW_USER
  end

  describe 'after initialization' do
    RAW_USER.each do |field, value|
      it "respond to #{field}" do
        expect(@user.send field).to eq(value)
      end
    end
  end
end
