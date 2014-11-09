describe 'Questions API' do
  let(:access_token) { create(:access_token) }
  describe 'GET questions' do
    context 'unauthorized' do
      it 'returns 401 status if no access token' do
        get '/api/v1/questions', format: :json
        expect(response).to have_http_status(401)
      end
      it 'returns 401 status if access token is incorrect' do
        get '/api/v1/questions', format: :json, access_token: '1234'
        expect(response).to have_http_status(401)
      end
    end

    context 'authorized' do
      let!(:questions) { create_list(:question, 2) }
      let!(:question) { questions.first }
      let!(:answer) { create(:answer, question: question) }

      before(:each) do
        get '/api/v1/questions', format: :json, access_token: access_token.token
      end

      it 'returns response' do
        expect(response).to be_success
      end

      it 'returns list questions' do
        expect(response.body).to have_json_size(2).at_path('questions')
      end

      it 'returns short title' do
        expect(response.body).to be_json_eql(question.title.truncate(7).to_json).at_path('questions/0/short_title')
      end

      %w(id title body created_at updated_at).each do |attr|
        it "returns #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("questions/0/#{attr}")
        end
      end

      context 'answers' do
        it 'included in question' do
          expect(response.body).to have_json_size(1).at_path('questions/0/answers')
        end

        %w(id body created_at updated_at).each do |attr|
          it "contains #{attr}" do
            expect(response.body).to be_json_eql(answer.send(attr.to_sym).to_json).at_path("questions/0/answers/0/#{attr}")
          end
        end
      end
    end
  end

  describe 'GET question' do
    context 'authorized' do
      let(:attachment) { create(:attachment) }
      let!(:question) { create(:question, comments: create_list(:comment, 1), attachments: [attachment]) }
      let(:comment) { question.comments.first }

      before(:each) do
        get "/api/v1/questions/#{question.id}", format: :json, access_token: access_token.token
      end

      it 'returns response' do
        expect(response).to be_success
      end

      %w(id title body created_at updated_at).each do |attr|
        it "returns #{attr}" do
          expect(response.body).to be_json_eql(question.send(attr.to_sym).to_json).at_path("#{attr}")
        end
      end

      context 'comment' do
        %w(id body user_id).each do |attr|
          it "returns #{attr}" do
            expect(response.body).to be_json_eql(comment.send(attr.to_sym).to_json).at_path("comments/0/#{attr}")
          end
        end
      end

      context 'attachments' do
        it "returns url" do
          expect(response.body).to be_json_eql(attachment.file.url.to_json).at_path("attachments/0/url")
        end
      end
    end
  end

end