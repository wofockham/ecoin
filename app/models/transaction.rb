# == Schema Information
#
# Table name: transactions
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  merchant_id :integer
#  amount      :decimal(8, 2)    default(0.0)
#  date        :datetime
#  auth_code   :integer
#  status      :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Transaction < ActiveRecord::Base
  attr_accessible :user_id, :merchant_id, :amount, :date, :auth_code, :status
  belongs_to :user
  belongs_to :merchant


before_create do
  user = User.find(self.user_id)
  balance = user.transactions.sum(:amount)



if self.amount < 0 && self.amount.abs > balance
  return false
end

if self.amount < 0
  self.auth_code = rand(1000)
end

end

end







