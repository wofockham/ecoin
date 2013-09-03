class MerchantsController < ApplicationController

    def new
      # @merchant = Merchant.new
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

    notification = {}


    if trans.nil?
      # Problem -- insuffiient funds
      # render :no_funds
       # binding.pry
      notification['status'] = 'insufficient'

    elsif trans.auth_code != nil

      auth_code = trans.auth_code
      code = "Your authorization code is #{auth_code}"

      ###code = code + user.get_url

      client = Twilio::REST::Client.new(ENV['TW_SID'], ENV['TW_TOK'])
      client.account.sms.messages.create(:from => '+17274935134',
                                                              :to => user.phone,
                                                              :body => code )

      notification['status'] = 'pending'
      notification['trans_id'] = trans.id

    else

      balance = user.transactions.sum(:amount)
      message = message + "Your eCoin balance is #{ '$%.2f' % balance }"

      client = Twilio::REST::Client.new(ENV['TW_SID'], ENV['TW_TOK'])
      client.account.sms.messages.create(:from => '+17274935134',
                                                              :to => user.phone,
                                                              :body => message )

        notification['status'] = 'verified'
        # notification['amount'] = 'amount'
      end
      # binding.pry
      render :json => notification
    end

    def redeem
    end

    def redeemtxt

      trans = Transaction.find(params[:trans_id])
      user = User.find trans.user_id
      balance = user.transactions.sum(:amount)
      notification = {}

      if trans.auth_code == params[:auth_code].to_i
        trans.status = 'Verified'
        trans.save
        notification['status'] = 'verified'

        message = "Your new eCoin balance is #{ '$%.2f' % balance }"

      client = Twilio::REST::Client.new(ENV['TW_SID'], ENV['TW_TOK'])
      client.account.sms.messages.create(:from => '+17274935134',
                                                              :to => user.phone,
                                                              :body => message )

      else
        notification['status'] = 'invalid'
    end
    render :json => notification
  end
end
