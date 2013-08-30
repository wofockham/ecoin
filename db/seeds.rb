User.destroy_all
Merchant.destroy_all
Transaction.destroy_all

u1 = User.create(:phone => '+61405519707')
u2 = User.create(:phone => '+61457131242')
m1 = Merchant.create(:name => 'Lego House', :email => 'lego@gmail.com', :password => 'a', :password_confirmation => 'a')
t1 = Transaction.create(:amount => '3.00' , :date => '2013-30-08', :auth_code => '123', :status => 'y' )
t2 = Transaction.create(:amount => '3.00' , :date => '2013-30-08', :auth_code => '123', :status => 'y' )
t3 = Transaction.create(:amount => '3.00' , :date => '2013-30-08', :auth_code => '123', :status => 'y' )
t4 = Transaction.create(:amount => '-4.00' , :date => '2013-30-08', :auth_code => '123', :status => 'y' )
t5 = Transaction.create(:amount => '5.00' , :date => '2013-30-08', :auth_code => '123', :status => 'y' )
t6 = Transaction.create(:amount => '5.00' , :date => '2013-30-08', :auth_code => '123', :status => 'y' )
t7 = Transaction.create(:amount => '5.00' , :date => '2013-30-08', :auth_code => '123', :status => 'y' )
t8 = Transaction.create(:amount => '-3.00' , :date => '2013-30-08', :auth_code => '123', :status => 'y' )


u1.transactions << t1
u1.transactions << t2
u1.transactions << t3
u1.transactions << t4

u2.transactions << t5
u2.transactions << t6
u2.transactions << t7
u2.transactions << t8


m1.transactions <<  t1
m1.transactions <<  t2
m1.transactions <<  t3
m1.transactions <<  t4
m1.transactions <<  t5
m1.transactions <<  t6
m1.transactions <<  t7
m1.transactions <<  t8