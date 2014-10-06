require 'spec_helper'

describe Dribbble::Client do
  before :all do
    @base = Dribbble::Base.new 'valid_token', {}
  end

  describe 'on #full_url' do
    describe 'without params' do
      subject { @base.full_url '/shots' }

      it 'return a valid url' do
        expect(subject).to eq('https://api.dribbble.com/v1/shots?page=1&per_page=100')
      end
    end

    describe 'with default params overrided' do
      subject { @base.full_url '/shots', page: 2, per_page: 10 }

      it 'return a valid url' do
        expect(subject).to eq('https://api.dribbble.com/v1/shots?page=2&per_page=10')
      end
    end

    describe 'with extra params' do
      subject { @base.full_url '/shots', params1: 'custom' }

      it 'return a valid url' do
        expect(subject).to eq('https://api.dribbble.com/v1/shots?page=1&per_page=100&params1=custom')
      end
    end
  end
end
