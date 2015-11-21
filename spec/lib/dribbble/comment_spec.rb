require 'spec_helper'

RAW_COMMENT = data_from_json 'comment_success.json'

describe Dribbble::Comment do
  describe 'on instance' do
    before :all do
      @comment = Dribbble::Comment.new 'valid_token', RAW_COMMENT, '/shots/471756/comments'
    end

    describe 'after initialization' do
      RAW_COMMENT.each do |field, value|
        it "respond to #{field}" do
          expect(@comment.send field).to eq(value)
        end
      end
    end

    describe 'on #likes' do
      subject do
        stub_dribbble :get, '/shots/471756/comments/1145736/likes', DribbbleAPI::CommentLikesSuccess
        @comment.likes
      end

      it 'return a user' do
        expect(subject.first).to be_a Dribbble::Like
        expect(subject.first.user).to be_a Dribbble::User
      end
    end

    describe 'on #like?' do
      describe 'on a not liked shot' do
        subject do
          stub_dribbble :get, '/shots/471756/comments/1145736/like', DribbbleAPI::CommentLikeNotFound
          @comment.like?
        end

        it 'return a user' do
          expect(subject).to be_falsy
        end
      end

      describe 'on a liked shot' do
        subject do
          stub_dribbble :get, '/shots/471756/comments/1145736/like', DribbbleAPI::CommentLikeSuccess
          @comment.like?
        end

        it 'return a user' do
          expect(subject).to be_truthy
        end
      end
    end

    describe 'on #like!' do
      subject do
        stub_dribbble :post, '/shots/471756/comments/1145736/like', DribbbleAPI::CommentLikeCreated
        @comment.like!
      end

      it 'return true' do
        expect(subject).to be_truthy
      end
    end

    describe 'on #unlike!' do
      subject do
        stub_dribbble :delete, '/shots/471756/comments/1145736/like', DribbbleAPI::CommentLikeDeleted
        @comment.unlike!
      end

      it 'return true' do
        expect(subject).to be_truthy
      end
    end
  end
end
