class PagesController < ApplicationController

  def home
	@title = "Home"
  end
    
  def events
	@title = "Events"
  end
  
  def about_us
  	@title = "About Us"
  end

  def what_is_waznoo
	@title = "What Is Waznoo?"
  end

  def previous_deals
	@title = "Previous Deals"
  end

  def support_customers
	@title = "Customer Support"
  end

  def support_businesses
	@title = "For Businesses"
  end

  def subscribe
	@title = "Subscribe!"
  end
  
  

end
