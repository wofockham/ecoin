class MerchantsController < ApplicationController

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
      message = "Hey, welcome to eCoin! Your balance is #{amount}"
      Transaction.create(:amount => amount, :merchant_id => @merchant, :user_id => user.id)
    else
      Transaction.create(:amount => amount, :merchant_id => @merchant, :user_id => user.id)
      balance = user.transactions.sum(:amount)
      message = "Your eCoin balance is #{balance}"
    end

      client = Twilio::REST::Client.new(ENV['TW_SID'], ENV['TW_TOK'])
      client.account.sms.messages.create(:from => '+17274935134',
                                                            :to => user.phone,
                                                            :body => message )


      redirect_to(root_path)
    end


end
