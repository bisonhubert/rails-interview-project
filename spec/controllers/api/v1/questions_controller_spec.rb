describe Api::V1::QuestionsController do
  context 'valid token' do
    let(:tenant) { FactoryGirl.create(:tenant) }
    
    describe 'GET #index' do
      it 'returns a success 200 response' do
        request.headers['token'] = tenant.api_key
        get :index, :format => :json
        expect(response.status).to eq(200)
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
