class SessionController < ApplicationController
  def new
  end

  def create
    @merchant = Merchant.where(:email => params[:merchant][:email]).first

    if @merchant.present? && @merchant.authenticate(params[:merchant][:password])
      session[:merchant_id] = @merchant.id
      redirect_to(sendtxt_path)
    else
      redirect_to(login_path)
    end
  end

  def destroy
    session[:merchant_id] = nil
    redirect_to(root_path)
  end
end