# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  phone      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :phone
  has_many :transactions
  has_many :merchants
end
