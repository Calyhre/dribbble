require 'spec_helper'

RAW_USER = data_from_json 'user_success.json'

describe Dribbble::User do
  describe 'on instance' do
    before :all do
      @user = Dribbble::User.new 'valid_token', RAW_USER
    end

    describe 'after initialization' do
      RAW_USER.each do |field, value|
        it "respond to #{field}" do
          expect(@user.send field).to eq(value)
        end
      end
    end

    describe 'on #buckets' do
      subject do
        stub_dribbble :get, '/users/483195/buckets', DribbbleAPI::BucketsSuccess
        @user.buckets
      end

      it 'responds with buckets' do
        expect(subject.size).to eq 1
        expect(subject.first).to be_a Dribbble::Bucket
      end
    end

    describe '#followers' do
      subject do
        stub_dribbble :get, '/users/483195/followers', DribbbleAPI::FollowersSuccess
        @user.followers
      end

      it 'responds with users' do
        expect(subject.size).to eq 1
        expect(subject.first).to be_a Dribbble::User
        expect(subject.first.location).to eq 'Salem, MA'
      end
    end

    describe '#following' do
      subject do
        stub_dribbble :get, '/users/483195/following', DribbbleAPI::FollowingSuccess
        @user.following
      end

      it 'responds with users' do
        expect(subject.size).to eq 1
        expect(subject.first).to be_a Dribbble::User
        expect(subject.first.name).to eq('Dan Cederholm')
      end
    end

    describe 'on #following?' do
      describe 'for current logged user' do
        describe 'on a not followed user' do
          subject do
            stub_dribbble :get, '/user/following/483195', DribbbleAPI::UserFollowNotFound
            @user.following?
          end

          it 'return false' do
            expect(subject).to be_falsy
          end
        end

        describe 'on a followed user' do
          subject do
            stub_dribbble :get, '/user/following/483195', DribbbleAPI::UserFollowSuccess
            @user.following?
          end

          it 'return true' do
            expect(subject).to be_truthy
          end
        end
      end

      describe 'for another user' do
        describe 'on a not followed user' do
          subject do
            stub_dribbble :get, '/users/483195/following/1', DribbbleAPI::UserFollowNotFound
            @user.following? 1
          end

          it 'return false' do
            expect(subject).to be_falsy
          end
        end

        describe 'on a followed user' do
          subject do
            stub_dribbble :get, '/users/483195/following/1', DribbbleAPI::UserFollowSuccess
            @user.following? 1
          end

          it 'return true' do
            expect(subject).to be_truthy
          end
        end
      end
    end

    describe 'on #follow!' do
      subject do
        stub_dribbble :put, '/users/483195/follow', DribbbleAPI::UserFollowCreated
        @user.follow!
      end

      it 'return true' do
        expect(subject).to be_truthy
      end
    end

    describe 'on #unfollow!' do
      subject do
        stub_dribbble :delete, '/users/483195/follow', DribbbleAPI::UserFollowDeleted
        @user.unfollow!
      end

      it 'return true' do
        expect(subject).to be_truthy
      end
    end

    describe '#likes' do
      subject do
        stub_dribbble :get, '/users/483195/likes', DribbbleAPI::UserLikesSuccess
        @user.likes
      end

      it 'responds with shots' do
        expect(subject.size).to eq 1
        expect(subject.first).to be_a Dribbble::Shot
        expect(subject.first.title).to eq('Sasquatch')
      end
    end

    describe '#projects' do
      subject do
        stub_dribbble :get, '/users/483195/projects', DribbbleAPI::ProjectsSuccess
        @user.projects
      end

      it 'responds with projects' do
        expect(subject.size).to eq 1
        expect(subject.first).to be_a Dribbble::Project
      end
    end

    describe '#shots' do
      subject do
        stub_dribbble :get, '/users/483195/shots', DribbbleAPI::ShotsSuccess
        @user.shots
      end

      it 'responds with buckets' do
        expect(subject.size).to eq 2
        expect(subject.first).to be_a Dribbble::Shot
      end
    end

    describe '#teams' do
      subject do
        stub_dribbble :get, '/users/483195/teams', DribbbleAPI::TeamsSuccess
        @user.teams
      end

      it 'responds with teams' do
        expect(subject.size).to eq 1
        expect(subject.first).to be_a Dribbble::Team
      end
    end
  end

  describe 'on class' do
    describe 'on #find' do
      subject do
        stub_dribbble :get, '/users/483195', DribbbleAPI::UserSuccess
        Dribbble::User.find 'valid_token', 483_195
      end

      it 'return a user' do
        expect(subject).to be_a Dribbble::User
        expect(subject.id).to eq(483_195)
      end
    end
  end
end
