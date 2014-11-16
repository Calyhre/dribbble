require 'spec_helper'

RAW_SHOT = data_from_json 'shot_success.json'

describe Dribbble::Shot do
  describe 'on instance' do
    before :all do
      @shot = Dribbble::Shot.new 'valid_token', RAW_SHOT
    end

    describe 'after initialization' do
      RAW_SHOT.each do |field, value|
        it "respond to #{field}" do
          expect(@shot.send field).to eq(value)
        end
      end
    end

    describe 'on #update' do
      subject do
        stub_dribbble :put, '/shots/471756', DribbbleAPI::ShotUpdated
        new_shot = {
          title: 'Shot title',
          description: 'Shot description'
        }
        @shot.update new_shot
      end

      it 'update shot' do
        expect(subject.title).to eq('Shot title')
      end
    end

    describe 'on #delete' do
      subject do
        stub_dribbble :delete, '/shots/471756', DribbbleAPI::ShotDeleted
        @shot.delete
      end

      it 'return true' do
        expect(subject).to eq(true)
      end
    end

    describe 'on #attachments' do
      describe 'get all' do
        subject do
          stub_dribbble :get, '/shots/471756/attachments', DribbbleAPI::AttachmentsSuccess
          @shot.attachments
        end

        it 'return a shot' do
          expect(subject.first).to be_a Dribbble::Attachment
        end
      end

      describe 'create one' do
        subject do
          stub_dribbble :post, '/shots/471756/attachments', DribbbleAPI::Accepted
          @shot.create_attachment
        end

        it 'works' do
          expect(subject).to be_truthy
        end
      end
    end

    describe 'on #buckets' do
      subject do
        stub_dribbble :get, '/shots/471756/buckets', DribbbleAPI::BucketsSuccess
        @shot.buckets
      end

      it 'return a shot' do
        expect(subject.first).to be_a Dribbble::Bucket
      end
    end

    describe 'on #comments' do
      subject do
        stub_dribbble :get, '/shots/471756/comments', DribbbleAPI::CommentsSuccess
        @shot.comments
      end

      it 'return a shot' do
        expect(subject.first).to be_a Dribbble::Comment
      end
    end

    describe 'on #likes' do
      subject do
        stub_dribbble :get, '/shots/471756/likes', DribbbleAPI::ShotLikesSuccess
        @shot.likes
      end

      it 'return a user' do
        expect(subject.first).to be_a Dribbble::User
      end
    end

    describe 'on #like?' do
      describe 'on a not liked shot' do
        subject do
          stub_dribbble :get, '/shots/471756/like', DribbbleAPI::ShotLikeNotFound
          @shot.like?
        end

        it 'return a user' do
          expect(subject).to be_falsy
        end
      end

      describe 'on a liked shot' do
        subject do
          stub_dribbble :get, '/shots/471756/like', DribbbleAPI::ShotLikeSuccess
          @shot.like?
        end

        it 'return a user' do
          expect(subject).to be_truthy
        end
      end
    end

    describe 'on #like!' do
      subject do
        stub_dribbble :post, '/shots/471756/like', DribbbleAPI::ShotLikeCreated
        @shot.like!
      end

      it 'return true' do
        expect(subject).to be_truthy
      end
    end

    describe 'on #unlike!' do
      subject do
        stub_dribbble :delete, '/shots/471756/like', DribbbleAPI::ShotLikeDeleted
        @shot.unlike!
      end

      it 'return true' do
        expect(subject).to be_truthy
      end
    end

    describe 'on #projects' do
      subject do
        stub_dribbble :get, '/shots/471756/projects', DribbbleAPI::ProjectsSuccess
        @shot.projects
      end

      it 'return a list of project' do
        expect(subject.first).to be_a Dribbble::Project
      end
    end

    describe 'on #rebounds' do
      subject do
        stub_dribbble :get, '/shots/471756/rebounds', DribbbleAPI::ShotsSuccess
        @shot.rebounds
      end

      it 'return a list of shots' do
        expect(subject.first).to be_a Dribbble::Shot
      end
    end
  end

  describe 'on class' do
    describe 'on #create' do
      subject do
        stub_dribbble :post, '/shots', DribbbleAPI::ShotAccepted
        shot = {
          title: 'Shot title',
          desciption: 'Shot description',
          image: File.new("#{Dir.pwd}/spec/support/fixtures/image.jpg", 'rb'),
          tags: %w(tag1 tag2)
        }
        Dribbble::Shot.create 'valid_token', shot
      end

      it 'create the shot' do
        expect(subject).to eq(true)
      end
    end

    describe 'on #update' do
      subject do
        stub_dribbble :get, '/shots/471756', DribbbleAPI::ShotSuccess
        stub_dribbble :put, '/shots/471756', DribbbleAPI::ShotUpdated
        bucket = {
          name: 'Shot title',
          description: 'Shot description'
        }
        Dribbble::Shot.update 'valid_token', 471_756, bucket
      end

      it 'update bucket' do
        expect(subject.title).to eq('Shot title')
      end
    end

    describe 'on #delete' do
      subject do
        stub_dribbble :get, '/shots/471756', DribbbleAPI::ShotSuccess
        stub_dribbble :delete, '/shots/471756', DribbbleAPI::ShotDeleted
        Dribbble::Shot.delete 'valid_token', 471_756
      end

      it 'return true' do
        expect(subject).to eq(true)
      end
    end

    describe 'on #find' do
      subject do
        stub_dribbble :get, '/shots/471756', DribbbleAPI::ShotSuccess
        Dribbble::Shot.find 'valid_token', 471_756
      end

      it 'return a shot' do
        expect(subject).to be_a Dribbble::Shot
        expect(subject.id).to eq(471_756)
      end
    end

    describe 'on #all' do
      subject do
        stub_dribbble :get, '/shots', DribbbleAPI::ShotsSuccess
        Dribbble::Shot.all 'valid_token'
      end

      it 'return a shot' do
        expect(subject.first).to be_a Dribbble::Shot
      end
    end
  end
end
