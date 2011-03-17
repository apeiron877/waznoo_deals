# == Schema Information
# Schema version: 20110224063515
#
# Table name: coupons
#
#  id            :integer         not null, primary key
#  name          :string(255)
#  company       :string(255)
#  expires_on    :string(255)
#  fine_print    :string(255)
#  days_to_regen :integer
#  redeemable_at :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  image_url     :string(255)
#  barcode_url   :string(255)
#

class Coupon < ActiveRecord::Base
  attr_accessible :name, :company, :expires_on, :fine_print, :redeemable_at, :days_to_regen, :image_url
  
  date_regex = /[0-1]{1}[0-9]{1}\/[0-3]{1}[0-9]{1}\/2[0-9]{3}/
  
  validates :name, :presence => true, :length => { :maximum => 140 }
  validates :company, :presence => true, :length => { :maximum => 60 }
  validates :expires_on, :presence => true,
					     :format => { :with => date_regex }
  validates :redeemable_at, :presence => true, :length => { :maximum => 140 }
  validates :fine_print, :presence => true, :length => { :maximum => 500 }
  validates :days_to_regen, :presence => true, :inclusion => { :in => 1..14}
  validates :image_url, :presence => true
  validates :barcode_url, :presence => true
  
  has_many :users, :through => :used_coupons, :source => "user_id"
  
end
