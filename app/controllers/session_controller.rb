class SessionController < ApplicationController

  def new
  end

  def create
  @merchant = Merchant.where(:email => params[:email]).first
  if merchant.present? && merchant.authenticate(params[:password])
  session[:merchant_id] = merchant.id
  redirect_to(root_path)
  else
  redirect_to(login_path)
  end
  end

  def destroy
  session[:merchant_id] = nil
  redirect_to(root_path)
  end
end