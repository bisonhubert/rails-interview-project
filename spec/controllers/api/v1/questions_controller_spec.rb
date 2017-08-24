describe Api::V1::QuestionsController do
  render_views

  context 'valid token' do
    let(:tenant) { FactoryGirl.create(:tenant) }
    
    describe 'GET #index' do
      before(:each) do
        FactoryGirl.create_list(:question, 10)
        request.headers['token'] = tenant.api_key
        get :index, :format => :json
        @json = JSON.parse(response.body)
      end

      it 'returns a success 200 response' do
        expect(response.status).to eq(200)
      end

      it 'returns a list of public questions' do
        expect(@json.length).to eq(10)
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