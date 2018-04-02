require 'spec_helper'

describe Dribbble::Client do
  before :all do
    @base = Dribbble::Base.new 'valid_token', {}
  end

  describe 'on #full_url_with_default_params' do
    describe 'without params' do
      subject { @base.full_url_with_default_params '/shots' }

      it 'return a valid url' do
        expect(subject).to eq('https://api.dribbble.com/v2/shots?page=1&per_page=100')
      end
    end

    describe 'with default params overrided' do
      subject { @base.full_url_with_default_params '/shots', page: 2, per_page: 10 }

      it 'return a valid url' do
        expect(subject).to eq('https://api.dribbble.com/v2/shots?page=2&per_page=10')
      end
    end

    describe 'with extra params' do
      subject { @base.full_url_with_default_params '/shots', params1: 'custom' }

      it 'return a valid url' do
        expect(subject).to eq('https://api.dribbble.com/v2/shots?page=1&per_page=100&params1=custom')
      end
    end
  end

  describe 'on #full_url' do
    describe 'without params' do
      subject { @base.full_url '/shots' }

      it 'return a valid url' do
        expect(subject).to eq('https://api.dribbble.com/v2/shots?')
      end
    end

    describe 'with params' do
      subject { @base.full_url '/shots', custom: 1 }

      it 'return a valid url' do
        expect(subject).to eq('https://api.dribbble.com/v2/shots?custom=1')
      end
    end
  end
end
