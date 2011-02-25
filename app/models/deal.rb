# == Schema Information
# Schema version: 20110224063515
#
# Table name: deals
#
#  id                   :integer         not null, primary key
#  name                 :string(255)
#  starting_date        :string(255)
#  days_available       :integer
#  price                :integer
#  value                :integer
#  num_available        :integer
#  num_purchased        :integer
#  num_needed_to_unlock :integer
#  blurb                :string(255)
#  expires              :string(255)
#  company              :string(255)
#  location             :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

class Deal < ActiveRecord::Base
  attr_accessible :name, :starting_date, :days_available, :price,
                  :value, :num_available, :num_purchased,
                  :num_needed_to_unlock, :blurb, :expires,
                  :company, :location
  date_regex = /[0-1]{1}[0-9]{1}\/[0-3]{1}[0-9]{1}\/2[0-9]{3}/
  
  # every deal must have a unique name between 10 and 140 characters
  validates :name, :presence => true,
                   :length => { :maximum => 140, :minimum => 10 },
                   :uniqueness => true 
  
  # a deal can start between Jan 1, 2011, and Dec 31, 2999 
  # it must be in the form xx/xx/xxxx, ie 05/14/2013
  # 2 deals can't start on the same day (current implementation)                 
  validates :starting_date, :presence => true,
							:uniqueness => true,
							:format => { :with => date_regex } 
  
  # a deal can expire between Jan 1, 2011, and Dec 31, 2999 
  # it must be in the form xx/xx/xxxx, ie 05/14/2013
  # NOTE this is the day the company stops accepting vouchers.                 
  validates :expires, :presence => true,
					  :format => { :with => date_regex }
							
							
  # a deal must be available for 1 to 14 days
  validates :days_available, :presence => true,
							 :inclusion => { :in => 1..14}
	
  # price must be between $1 and $1000	
  validates :price, :presence => true,
					:inclusion => { :in => 100..100000}	
					
  # value must be between $1 and $1000 (where value-price = savings)	
  validates :value, :presence => true,
					:inclusion => { :in => 100..100000}				
										
  # number available must be between 5 and 500 
  validates :num_available, :presence => true,
					        :inclusion => { :in => 5..500}											  						
							
  # number purchased must be between 0 and num available 
  validates :num_purchased, :presence => true,
					        :inclusion => { :in => 0..500}
	
  # number needed to unlock must be between 1 and num available 
  validates :num_needed_to_unlock, :inclusion => { :in => 1..500}			

  # every deal must have a unique blurb between 10 and 2000 characters
  validates :blurb, :presence => true,
                   :length => { :maximum => 2000, :minimum => 10 },
                   :uniqueness => true 			
                   
  # every deal must have a company name between 4 and 140 characters
  validates :company, :presence => true,
                      :length => { :maximum => 140, :minimum => 4 }
                    
  # every deal must have a location between 4 and 140 characters
  validates :location, :presence => true,
                       :length => { :maximum => 140, :minimum => 4 }        
               
         
         
         
         
                  

end
