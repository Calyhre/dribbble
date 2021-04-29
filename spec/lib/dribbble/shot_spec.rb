# frozen_string_literal: true

require 'spec_helper'

RAW_SHOT = data_from_json 'shot_success.json'

describe Dribbble::Shot do
  describe 'on instance' do
    before do
      @shot = described_class.new 'valid_token', RAW_SHOT
    end

    describe 'after initialization' do
      RAW_SHOT.each do |field, value|
        it "respond to #{field}" do
          expect(@shot.send(field)).to eq(value)
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

    skip 'on #attachments' do
      describe 'create' do
        describe 'when shot is accepted' do
          subject do
            stub_dribbble :post, '/shots/471756/attachments', DribbbleAPI::Accepted
            @shot.create_attachment
          end

          it 'works' do
            expect(subject).to eq(true)
          end
        end

        describe 'with a 422 error' do
          subject do
            stub_dribbble :post, '/shots/471756/attachments', DribbbleAPI::Unprocessable
            @shot.create_attachment
          end

          it 'works' do
            expect { subject }.to raise_error(Dribbble::Error::Unprocessable)
          end
        end
      end

      describe 'delete' do
        subject do
          stub_dribbble :delete, '/shots/471756/attachments/206165', DribbbleAPI::AttachmentDeleted
          @shot.delete_attachment 206_165
        end

        it 'return true' do
          expect(subject).to eq(true)
        end
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
          tags: %w[tag1 tag2]
        }
        described_class.create 'valid_token', shot
      end

      it 'create the shot' do
        expect(subject).to be_truthy
        expect(subject).to eq('471756')
      end
    end

    describe 'on #update' do
      subject do
        stub_dribbble :get, '/shots/471756', DribbbleAPI::ShotSuccess
        stub_dribbble :put, '/shots/471756', DribbbleAPI::ShotUpdated
        data = {
          name: 'Shot title',
          description: 'Shot description'
        }
        described_class.update 'valid_token', 471_756, data
      end

      it 'update data' do
        expect(subject.title).to eq('Shot title')
      end
    end

    describe 'on #delete' do
      subject do
        stub_dribbble :get, '/shots/471756', DribbbleAPI::ShotSuccess
        stub_dribbble :delete, '/shots/471756', DribbbleAPI::ShotDeleted
        described_class.delete 'valid_token', 471_756
      end

      it 'return true' do
        expect(subject).to eq(true)
      end
    end

    describe 'on #find' do
      subject do
        stub_dribbble :get, '/shots/471756', DribbbleAPI::ShotSuccess
        described_class.find 'valid_token', 471_756
      end

      it 'return a shot' do
        expect(subject).to be_a described_class
        expect(subject.id).to eq(471_756)
      end
    end
  end
end
