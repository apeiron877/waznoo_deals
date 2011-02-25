require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "admin",
                         :email => "admin@waznoodeals.com",
                         :password => "waz-admin",
                         :password_confirmation => "waz-admin")
    admin.toggle!(:admin)
    test_user = User.create!(:name => "test user",
                         :email => "user@waznoodeals.com",
                         :password => "waz-test",
                         :password_confirmation => "waz-test")
                         
    rhino = Coupon.create(:name => "$10 off a purchase of $25 or more at Rhino Records!", 
			 :expires_on => "05/12/2012",
			 :days_to_regen => 7,
			 :company => "Rhino Records",
			 :redeemable_at => "235 Yale Avenue, Claremont, CA 91711",
			 :fine_print => "Limit one coupon per purchase. Can not be combined with any other offer.",
			 :image_url => "https://s3-us-west-1.amazonaws.com/waznoodeals-images/coupons/rhino-records.png"      
             )
    rhino.barcode_url = "https://s3-us-west-1.amazonaws.com/waznoodeals-images/coupons/barcode.gif"          
    rhino.save!
    
    casablanca = Coupon.create(:name => "$15 for a $25 gift certificate to Casablanca Bar and Grill!", 
			 :expires_on => "04/02/2012",
			 :days_to_regen => 14,
			 :company => "Casablanca Bar and Drill",
			 :redeemable_at => "175 First Street, Claremont, CA 91711",
			 :fine_print => "Must be used on food. Not valid with any other offer.",
			 :image_url => "https://s3-us-west-1.amazonaws.com/waznoodeals-images/coupons/casablanca.png"      
             )
    casablanca.barcode_url = "https://s3-us-west-1.amazonaws.com/waznoodeals-images/coupons/barcode.gif"          
    casablanca.save!
    
    
            
    27.times do |n|
      puts "processing #{n}"
      name  = Faker::Name.name
      email = "example-#{n+1}@waznoodeals.org"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
      coupon = Coupon.create(:name => "Test Coupon #{n}", 
			  :expires_on => "12/11/2012",
			  :days_to_regen => 7,
			  :company => "Waznoo Deals",
			  :redeemable_at => "170 East 6th Street",
			  :fine_print => "Be sure to read the fine print",
			  :image_url => "https://s3-us-west-1.amazonaws.com/waznoodeals-images/coupons/default.png")       
      coupon.barcode_url = "https://s3-us-west-1.amazonaws.com/waznoodeals-images/coupons/barcode.gif"    
      coupon.save!
      
    end
    
    @deal_attr = { :name => "Default Deal!", 
			  :price => 2500,
			  :value => 4100,
			  :starting_date => "02/21/2011",
			  :days_available => 12,
			  :num_available => 200,
			  :num_purchased => 0,
			  :num_needed_to_unlock => 15,
			  :blurb => "Here is a short blurb about the default deal.",
             :expires => "07/14/2011",
			 :location => "www.waznoodeals.com",
			 :company => "Waznoo Deals"
           }
    @deal = Deal.create!(@deal_attr) 
  end
end
