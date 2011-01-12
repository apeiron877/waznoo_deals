class Deal < ActiveRecord::Base
  attr_accessible :name, :starting_date, :days_available, :price
                  :value, :num_available, :num_purchased,
                  :num_needed_to_unlock, :blurb, :expires,
                  :company, :location
           
  # every deal must have a unique name between 10 and 140 characters
  validates :name, :presence => true,
                   :length => { :maximum => 140, :minimum => 10 },
                   :uniqueness => true 
  
  # a deal can start between Jan 1, 2010, and Dec 31, 9999  
  # and 2 deals can't start on the same day (current implementation)                 
  validates :starting_date, :presence => true,
							:inclusion => { :in => 01012010..12319999},
							:uniqueness => true
  
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
  validates :num_available, :presence => true,
					        :inclusion => { :in => 0..:num_available}
	
  # number needed to unlock must be between 1 and num available 
  validates :num_needed_to_unlock, :presence => true,
					        :inclusion => { :in => 1..:num_available}			

  # every deal must have a unique blurb between 10 and 2000 characters
  validates :blurb, :presence => true,
                   :length => { :maximum => 2000, :minimum => 10 },
                   :uniqueness => true 			
		
  # a deal can expire between Jan 1, 2010, and Dec 31, 9999   
  # NOTE: This is the day the business stops accepting the printed 
  # coupon, not the day we stop offering the deal!               
  validates :expires, :presence => true,
				      :inclusion => { :in => 01012010..12319999},	
		
  # every deal must have a company name between 4 and 140 characters
  validates :company, :presence => true,
                      :length => { :maximum => 140, :minimum => 4 },
                    
  # every deal must have a location between 4 and 140 characters
  validates :location, :presence => true,
                       :length => { :maximum => 140, :minimum => 4 },                  
   	
			
			         
                  
                  
                  

end
