class PagesController < ApplicationController
  def home
	@title = "Home"
  end
  
  def coupons
	@title = "Coupons"
  end

  def events
	@title = "Events"
  end

  def philosophy
	@title = "Our Philosophy"
  end

  def how_it_works
	@title = "How It Works"
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
