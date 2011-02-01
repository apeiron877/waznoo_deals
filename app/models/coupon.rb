class Coupon < ActiveRecord::Base
  attr_accessible :name, :company, :expires_on, :fine_print, :redeemable_at, :days_to_regen
  
  date_regex = /[0-1]{1}[0-9]{1}\/[0-3]{1}[0-9]{1}\/2[0-9]{3}/
  
  validates :name, :presence => true, :length => { :maximum => 140 }
  validates :company, :presence => true, :length => { :maximum => 60 }
  validates :expires_on, :presence => true,
					     :format => { :with => date_regex }
  validates :redeemable_at, :presence => true, :length => { :maximum => 140 }
  validates :fine_print, :presence => true, :length => { :maximum => 500 }
  validates :days_to_regen, :presence => true, :inclusion => { :in => 1..14}



end
