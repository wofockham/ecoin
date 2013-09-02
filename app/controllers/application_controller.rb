class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate
  skip_before_filter  :verify_authenticity_token
private
  def authenticate
    return unless session[:merchant_id]
    @merchant = Merchant.find(session[:merchant_id])
    unless @merchant
    session[:merchant_id] = nil
    redirect_to(root_path)
    end
  end

  def check_if_admin
    redirect_to(root_path) if @merchant.nil? || @merchant.is_admin?
  end
end

