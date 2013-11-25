class MerchantsController < ApplicationController
  def new
    # @merchant = Merchant.new
  end

  def show
    @transactions = Transaction.where(:merchant_id => @merchant.id)
    @balance = Transaction.select([:amount]).where(:merchant_id => @merchant.id).sum(:amount)
     # render :json => @transactions
  end

  def merch_chart
    render :json => @transactions = Transaction.where(:merchant_id => @merchant.id)
  end

  def merch_bal
    @transactions = Transaction.where(:merchant_id => @merchant.id)
    balance = 0
    @transactions.each do |t|
      new_transaction = t.amount
      t.amount = new_transaction + balance
      balance = balance + new_transaction
    end
    render :json => @transactions
  end

  # Untested but fingers crossed.
  def all_merch_bal
    merchants = Merchant.all
    merchant_summaries = @merchants.map do |merchant|
      transactions = Transaction.where(:merchant_id => merchant.id)
      balance = 0
      transactions.each do |t|
        # Not sure what exactly this does but it seems to work.
        new_transaction = t.amount
        t.amount = new_transaction + balance
        balance = balance + new_transaction
      end
      # Return a hash with the merchant ID and balance.
      {:merchant_id => merchant.id, :balance => balance, :transactions => transactions}
    end
    render :json => merchant_summaries
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

    trans = Transaction.create(:amount => amount, :merchant_id => @merchant.id, :user_id => user.id,)

    notification = {}

    if !trans.persisted?
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
      url = user.get_url
      balance = user.transactions.sum(:amount)
      message = message + "Your eCoin balance is #{ '$%.2f' % balance }, see your chart #{url}"

      begin
        client = Twilio::REST::Client.new(ENV['TW_SID'], ENV['TW_TOK'])
        msg = client.account.sms.messages.create(:from => '+17274935134',
                                                 :to => user.phone,
                                                 :body => message )
      rescue Twilio::Rest::RequestError => e
          logger.info e.message
      end

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
      url =  user.get_url

      message = "Your new eCoin balance is #{ '$%.2f' % balance }, see your chart #{url}"

      client = Twilio::REST::Client.new(ENV['TW_SID'], ENV['TW_TOK'])
      client.account.sms.messages.create(:from => '+17274935134',
                                                              :to => user.phone,
                                                              :body => message )
    else
      notification['status'] = 'invalid'
    end
    render :json => notification
  end

  def chart
    phone = params[:phone]
    user = User.find_by_phone(phone)
    if user.nil?
      user = User.create(:phone => phone)
    end

    # transactions = User.select([:amount, 'transactions.created_at']).joins(:transactions).where('users.phone' => params[:phone])
    # balance = 0
    # transactions.each do |t|
    #   new_transaction = t.amount.to_i
    #   t.amount = new_transaction + balance
    #   balance = balance + new_transaction
    # end

    transactions = []
    balance = 0
    user.transactions.select([:amount, :created_at]).each do |t|
      balance += t.amount
      transactions << {:amount => balance, :created_at => t.created_at}
    end

    render :json => transactions
    # render :json => User.select([:amount, 'transactions.created_at']).joins(:transactions).where('users.phone' => params[:phone]).sum(:amount)
  end

  def sum
    phone = params[:phone]
    user = User.find_by_phone(phone)
    if user.nil?
      user = User.create(:phone => phone)
    end

    # render :json => User.select([:amount, 'transactions.created_at']).joins(:transactions).where('users.phone' => params[:phone])
    render :json => User.select([:amount, 'transactions.created_at']).joins(:transactions).where('users.phone' => params[:phone]).sum(:amount)
  end

  def lookupphone
    if params[:phone] && params[:phone].present?
      @user = User.find_by_phone(params[:phone])
      if @user
        redirect_to edit_merchant_path @user
      else
        redirect_to '/phone', :notice => 'Phone number does not exist'
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end
end
