require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "admin",
                         :email => "admin@waznoodeals.com",
                         :password => "foobar",
                         :password_confirmation => "foobar")
    admin.toggle!(:admin)
    27.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@waznoodeals.org"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
      Coupon.create!(:name => "Test Coupon #{n}", 
			  :expires_on => "12/11/2012",
			  :days_to_regen => 7,
			  :company => "Waznoo Deals",
			  :redeemable_at => "170 East 6th Street",
			  :fine_print => "Be sure to read the fine print",
			  :image_url => "https://s3-us-west-1.amazonaws.com/waznoodeals-images/coupons/default.png")           
    end
    
    @deal_attr = { :name => "Default Deal!", 
			  :price => 2500,
			  :value => 4100,
			  :starting_date => "01/26/2011",
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
