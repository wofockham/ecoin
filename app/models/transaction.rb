# == Schema Information
#
# Table name: transactions
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  merchant_id :integer
#  amount      :float
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
end
