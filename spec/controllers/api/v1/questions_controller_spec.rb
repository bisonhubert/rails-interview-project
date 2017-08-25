describe Api::V1::QuestionsController do
  render_views

  context 'valid token' do
    let(:tenant) { FactoryGirl.create(:tenant) }
    let(:user) { FactoryGirl.create(:user) }
    let(:question) { FactoryGirl.create(:question) }
    let(:private_question) { FactoryGirl.create(:question, private: true) }
    let(:answer) { FactoryGirl.create(:answer, user_id: user.id, question_id: question.id) }
    
    describe 'GET #index' do
      before(:each) do

      end

      it 'returns a success 200 response' do
        request.headers['token'] = tenant.api_key
        get :index, :format => :json
        json = JSON.parse(response.body)
        expect(response.status).to eq(200)
      end

      it 'returns a list of public questions' do
        number_of_questions = 10
        questions = FactoryGirl.create_list(:question, number_of_questions)
        request.headers['token'] = tenant.api_key
        get :index, :format => :json
        json = JSON.parse(response.body)
        expect(json['questions'].length).to eq(number_of_questions)
      end
      
      it 'does not return private questions' do
        user
        question
        private_question
        request.headers['token'] = tenant.api_key
        get :index, :format => :json
        json = JSON.parse(response.body)
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
        request.headers['token'] = tenant.api_key
        get :index, :format => :json
        json = JSON.parse(response.body)
        expect(json['questions'].first['answers'].first['id']).to eq(answer.id)
      end
    end
  end

  context 'invalid token' do
    describe 'GET #index' do
      it 'returns an unauthorized 401 response' do
        get :index
        expect(response.status).to eq(401)
      end
    end
  end
end