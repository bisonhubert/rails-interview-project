describe Api::V1::QuestionsController do
  render_views

  context 'valid token' do
    let(:tenant) { FactoryGirl.create(:tenant) }
    let(:user) { FactoryGirl.create(:user) }
    let(:question) { FactoryGirl.create(:question) }
    let(:private_question) { FactoryGirl.create(:question, private: true) }
    let(:questions_list) { FactoryGirl.create_list(:question, 10) }
    let(:answer) { FactoryGirl.create(:answer, user_id: user.id, question_id: question.id) }
    
    describe 'GET #index' do
      it 'returns a success 200 response' do
        send_request_token
        expect(response.status).to eq(200)
      end

      it 'returns a list of public questions' do
        questions_list
        send_request_token
        expect(json['questions'].length).to eq(10)
      end
      
      it 'does not return private questions' do
        user
        question
        private_question
        send_request_token
        tracker = false
        json['questions'].each do |question|
          tracker = true if question['id'] == private_question.id
        end
        expect(tracker).to be_falsey
      end

      it 'returns answers associated with a question' do
        user
        question
        answer
        send_request_token
        expect(json['questions'].first['answers'].first['id']).to eq(answer.id)
      end
    end
  end

  context 'invalid token' do
    describe 'GET #index' do
      it 'returns an unauthorized 401 response' do
        get :index, :format => :json
        expect(response.status).to eq(401)
      end
    end
  end
end