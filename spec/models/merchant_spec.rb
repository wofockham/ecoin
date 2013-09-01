# == Schema Information
#
# Table name: merchants
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require "spec_helper"



describe Merchant do
  it "is named Lego House" do
    merchant = Merchant.create(:name => "Lego House")
    # merchant = Merchant.new
    merchant.name.should == 'Lego House'
  end

  it "has an email that is lego@gmail.com" do
    merchant = Merchant.create(:email => 'lego@gmail.com')
    merchant.email.should == 'lego@gmail.com'
  end

  it "should not create without a password" do
    merchant = Merchant.create(:name => 'Lego House', :email => 'lego@gmail.com')
    merchant.id.should be_nil
  end
end