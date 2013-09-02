class MerchantsController < ApplicationController

    def new
      @merchant = Merchant.new
    end

    def create
      merchant = Merchant.create(params[:merchant])
      session[:merchant_id] = merchant.id
      redirect_to(sendtxt_path)
    end


    def index
      @users = User.all
      @transactions = Transaction.all
    end

    def sendtxt
      phone = params["phone"]
      amount = params["amount"]
      user = User.find_by_phone(phone)
    #user = User.where(:phone => phone).first
    if user.nil?
      user = User.create(:phone => phone)
    end

    message = ''
    if user.transactions.empty?
      message = "Hey, welcome to eCoin! "
    end

    trans = Transaction.create(:amount => amount, :merchant_id => @merchant, :user_id => user.id)

    if trans.nil?
      # Problem -- insuffiient funds
      # render :no_funds
       # binding.pry
       redirect_to(root_path)
    elsif trans.auth_code != nil

      auth_code = trans.auth_code
      code = "Your authorization code is #{auth_code}"

      client = Twilio::REST::Client.new(ENV['TW_SID'], ENV['TW_TOK'])
      client.account.sms.messages.create(:from => '+17274935125',
                                                              :to => user.phone,
                                                              :body => code )
      redirect_to(redeem_path(trans.id))

    else

      balance = user.transactions.sum(:amount)
      message = message + "Your eCoin balance is #{ '$%.2f' % balance }"

      client = Twilio::REST::Client.new(ENV['TW_SID'], ENV['TW_TOK'])
      client.account.sms.messages.create(:from => '+17274935125',
                                                              :to => user.phone,
                                                              :body => message )

        redirect_to(sendtxt_path)
      end
    end

    def redeem
    end

    def redeemtxt
      trans = Transaction.find(params[:transaction_id])
      user = User.find trans.user_id
      balance = user.transactions.sum(:amount)

      if trans.auth_code == params[:auth_code].to_i
        trans.status = 'Verified'
        trans.save
        # flash[:notice] = "Post successfully created"

        message = "Your new eCoin balance is #{ '$%.2f' % balance }"

      client = Twilio::REST::Client.new(ENV['TW_SID'], ENV['TW_TOK'])
      client.account.sms.messages.create(:from => '+17274935134',
                                                              :to => user.phone,
                                                              :body => message )
      redirect_to(sendtxt_path)
      else
      redirect_to(root_path)
    end
  end
end
