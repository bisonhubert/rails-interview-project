describe Api::V1::QuestionsController do
  context 'invalid token' do
    describe 'GET #index' do
      it 'returns an unauthorized 401 response' do
        get :index
        expect(response.status).to eq(401)
      end
    end
  end
end
