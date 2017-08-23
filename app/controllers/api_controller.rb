class ApiController < ApplicationController 
  before_action :authenticate_tenant
  skip_before_action :verify_authenticity_token

  private

  def authenticate_tenant
    tenant_token = request.headers['X-USER-TOKEN']
    if tenant_token
      tenant = Tenant.find_by_token(tenant_token)
      if tenant.nil?
        return unauthorize
      end
    else
      return unauthorize
    end
  end

  def unauthorize
    head status: :unauthorized
    return false
  end
end