# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  phone      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sha1       :text
#

class User < ActiveRecord::Base
  attr_accessible :phone
  has_many :transactions
  before_create do
    self.sha1 = Digest::SHA1.hexdigest self.phone
  end

  def get_url
    #'http://ecoin.com/u/' + self.sha1
    'http://localhost:3000/u/' + self.sha1


  end

end
