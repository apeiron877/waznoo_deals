class UsedCoupon < ActiveRecord::Base
  validates :user_id, :presence => true
  validates :coupon_id, :presence => true




end
