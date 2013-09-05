class UserController < ApplicationController
   def profile

    sha1 = params[:sha1]
    @user = User.find_by_sha1(sha1)
    @balance = @user.transactions.sum(:amount)
  end

  def update
  user = User.find(params[:id])
  user.update_attributes(params[:user])
  redirect_to(root_path)
  end
end


# get '/u/:sha1' => 'users#profile'

# 'You auth code is 768 http://mysite.com/u/511b6670adaf465da5c991f5f3b5ac955a6a49f3'


