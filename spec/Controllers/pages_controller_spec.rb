require 'spec_helper'

describe PagesController do
  render_views
	
  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end
    it "should have the right title" do
      get 'home'
      response.should have_selector("title",
				:content => "WaznooDeals! | Home")
    end
  end

  describe "GET 'coupons'" do
    it "should be successful" do
      get 'coupons'
      response.should be_success
    end
    it "should have the right title" do
      get 'coupons'
      response.should have_selector("title",
				:content => "WaznooDeals! | Coupons")
    end
  end

  describe "GET 'events'" do
    it "should be successful" do
      get 'events'
      response.should be_success
    end
    it "should have the right title" do
      get 'events'
      response.should have_selector("title",
				:content => "WaznooDeals! | Events")
    end
  end

  describe "GET 'philosophy'" do
    it "should be successful" do
      get 'philosophy'
      response.should be_success
    end
    it "should have the right title" do
      get 'philosophy'
      response.should have_selector("title",
				:content => "WaznooDeals! | Our Philosophy")
    end
  end

  describe "GET 'how_it_works'" do
    it "should be successful" do
      get 'how_it_works'
      response.should be_success
    end
    it "should have the right title" do
      get 'how_it_works'
      response.should have_selector("title",
				:content => "WaznooDeals! | How It Works")
    end
  end

  describe "GET 'previous_deals'" do
    it "should be successful" do
      get 'previous_deals'
      response.should be_success
    end
    it "should have the right title" do
      get 'previous_deals'
      response.should have_selector("title",
				:content => "WaznooDeals! | Previous Deals")
    end
  end

  describe "GET 'support_customers'" do
    it "should be successful" do
      get 'support_customers'
      response.should be_success
    end
    it "should have the right title" do
      get 'support_customers'
      response.should have_selector("title",
				:content => "WaznooDeals! | Customer Support")
    end
  end

  describe "GET 'support_businesses'" do
    it "should be successful" do
      get 'support_businesses'
      response.should be_success
    end
    it "should have the right title" do
      get 'support_businesses'
      response.should have_selector("title",
				:content => "WaznooDeals! | For Businesses")
    end
  end

  describe "GET 'subscribe'" do
    it "should be successful" do
      get 'subscribe'
      response.should be_success
    end
    it "should have the right title" do
      get 'subscribe'
      response.should have_selector("title",
				:content => "WaznooDeals! | Subscribe!")
    end
  end



end
