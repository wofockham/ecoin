User.destroy_all
Merchant.destroy_all
Transaction.destroy_all

u1 = User.create(:phone => '+61405519707')
m1 = Merchant.create(:name => 'Lego House', :email => 'lego@gmail.com', :password => 'a', :password_confirmation => 'a')
t1 = Transaction.create(:amount => '1.50' , :date => '2013-30-08', :auth_code => '123', :status => 'y' )

u1.transactions << t1
m1.transactions <<  t1
