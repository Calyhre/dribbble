require 'spec_helper'

RAW_BUCKET = data_from_json 'bucket_success.json'

describe Dribbble::Bucket do
  describe 'on instance' do
    before :all do
      @bucket = Dribbble::Bucket.new 'valid_token', RAW_BUCKET
    end

    describe 'after initialization' do
      RAW_BUCKET.each do |field, value|
        it "respond to #{field}" do
          expect(@bucket.send field).to eq(value)
        end
      end
    end

    describe 'on #update' do
      subject do
        stub_dribbble :put, '/buckets/2754', DribbbleAPI::BucketUpdated
        new_bucket = {
          name: 'Bucket title',
          description: 'Bucket description'
        }
        @bucket.update new_bucket
      end

      it 'update bucket' do
        expect(subject.name).to eq('Bucket title')
      end
    end

    describe 'on #delete' do
      subject do
        stub_dribbble :delete, '/buckets/2754', DribbbleAPI::BucketDeleted
        @bucket.delete
      end

      it 'return true' do
        expect(subject).to eq(true)
      end
    end

    describe 'on #shots' do
      subject do
        stub_dribbble :get, '/bucket/2754/shots', DribbbleAPI::ShotsSuccess
        @bucket.shots
      end

      it 'responds with shots' do
        expect(subject.size).to eq 2
        expect(subject.first).to be_a Dribbble::Shot
      end
    end

    describe 'on #add_shot' do
      subject do
        stub_dribbble :put, '/buckets/2754/shots', DribbbleAPI::NoContent
        @bucket.add_shot '471756'
      end

      it 'add shot' do
        expect(subject).to eq(true)
      end
    end

    describe 'on #remove_shot' do
      subject do
        stub_dribbble :delete, '/buckets/2754/shots?shot_id=471756', DribbbleAPI::NoContent
        @bucket.remove_shot '471756'
      end

      it 'remove shot' do
        expect(subject).to eq(true)
      end
    end
  end

  describe 'on class' do
    describe 'on #create' do
      subject do
        stub_dribbble :post, '/buckets', DribbbleAPI::BucketCreated
        bucket = {
          name: 'Bucket title',
          description: 'Bucket description'
        }
        Dribbble::Bucket.create 'valid_token', bucket
      end

      it 'create the shot' do
        expect(subject).to be_a Dribbble::Bucket
      end
    end

    describe 'on #update' do
      subject do
        stub_dribbble :get, '/buckets/2754', DribbbleAPI::BucketSuccess
        stub_dribbble :put, '/buckets/2754', DribbbleAPI::BucketUpdated
        bucket = {
          name: 'Bucket title',
          description: 'Bucket description'
        }
        Dribbble::Bucket.update 'valid_token', 2754, bucket
      end

      it 'update bucket' do
        expect(subject.name).to eq('Bucket title')
      end
    end

    describe 'on #delete' do
      subject do
        stub_dribbble :get, '/buckets/2754', DribbbleAPI::BucketSuccess
        stub_dribbble :delete, '/buckets/2754', DribbbleAPI::BucketDeleted
        Dribbble::Bucket.delete 'valid_token', 2754
      end

      it 'return true' do
        expect(subject).to eq(true)
      end
    end

    describe 'on #find' do
      subject do
        stub_dribbble :get, '/buckets/2754', DribbbleAPI::BucketSuccess
        Dribbble::Bucket.find 'valid_token', 2754
      end

      it 'return a bucket' do
        expect(subject).to be_a Dribbble::Bucket
        expect(subject.id).to eq(2754)
      end
    end
  end
end
