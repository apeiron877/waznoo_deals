require 'spec_helper'

describe "LayoutLinks" do

  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end
  it "should have a Coupons page at '/coupons'" do
    get '/coupons'
    response.should have_selector('title', :content => "Coupons")
  end
  it "should have an Events page at '/events'" do
    get '/events'
    response.should have_selector('title', :content => "Events")
  end
  it "should have a signup page at '/users/new'" do
    get '/users/new'
    response.should have_selector('title', :content => "Sign up")
  end


end
