# == Schema Information
# Schema version: 20110115032915
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean
#

class User < ActiveRecord::Base
	attr_accessor :password
    attr_accessible :name, :email, :password, :password_confirmation
    has_one :order
    has_many :used_coupons, :foreign_key => "user_id",
                            :dependent => :destroy
    has_many :coupons, :through => :used_coupons, :source => "coupon_id"
    
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i


	validates :name, :presence => true,
                     :length => { :maximum => 50 }

	validates :email, :presence => true,
					  :format => { :with => email_regex },
					  :uniqueness => { :case_sensitive => false}
  
	# Automatically create the virtual attribute 'password_confirmation'.
    validates :password, :presence     => true,
                         :confirmation => true,
                         :length       => { :within => 6..40 }
	
	before_save :encrypt_password
	
	def has_password?(submitted_password)
      encrypted_password == encrypt(submitted_password)
    end

	def self.authenticate(email, submitted_password)
      user = find_by_email(email)
      return nil  if user.nil?
      return user if user.has_password?(submitted_password)
    end

	def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
    end


   def days_until_available(coupon)
      # check if the current user has used the coupon before,
      # and save the most recent one
     
      used_coupon = used_coupons.where(:coupon_id => coupon.id).last
	  if used_coupon == nil
		return 0 # coupon is available
      else
        regen = coupon.days_to_regen
	    used_on = used_coupon.created_at.to_datetime
	    return ((used_on+regen) - Date.today).to_i
	  end
    end		


    def use_coupon!(coupon)
      used_coupons.create!(:coupon_id => coupon.id)
    end




	private

	 
    
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

	def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

  end
