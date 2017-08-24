class ApiController < ApplicationController 
  before_action :authenticate_tenant
  before_action :track_tenant_api_request

  private

  def current_tenant
    tenant_token = request.headers['token'] || params['token']
    return nil unless tenant_token
    tenant ||= Tenant.find_by(api_key: tenant_token)
  end

  def authenticate_tenant
    return true if current_tenant
    head status: :unauthorized
    return false
  end

  def track_tenant_api_request
    current_tenant.increment!(:api_request_count)
  end
end
