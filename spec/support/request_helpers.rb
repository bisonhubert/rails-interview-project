module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body)
    end

    def send_request_token
      request.headers['token'] = tenant.api_key
      get :index, :format => :json
    end
  end
end