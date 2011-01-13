require 'spec_helper'

describe "Users" do
  before(:each) do
    @attr = { :name => "$19 for Medium-Sized, Personalized Bagguettes
						Photo Bag ($41 Value)", 
			  :price => 1700,
			  :value => 4100,
			  :starting_date => 01/13/2011,
			  :days_available => 5,
			  :num_available => 200,
			  :num_purchased => 138,
			  :num_needed_to_unlock => 15,
			  :blurb => "Without a stylish cosmetic bag, women are forced to wear beer helmets of lip gloss and bandoleers of mascara. Enjoy fashion and function with today's Groupon: for $19, today's deal gets you a personalized, medium-sized cosmetic bag from Bagettes ($41 value including shipping).
                         Bagettes allows customers to personalize their bags by incorporating their own photos and text into the design. Constructed from satin fabric and featuring a black nylon lining, the medium cosmetic bag is 8x5, giving it the volume to handle makeup, toiletries, and several hamsters. Images are embedded into the fibers of the bags rather than applied superficially to the surface, helping prevent fading and peeling over time and making the bags practical and durable ways to preserve special moments and to broadcast hilarious personal slogans. Images, from endearing shots of family members and pets to psychedelic portraiture of famous flightless birds, are submitted using the Bagettes website and can be cropped, resized, and rotated to fit the customer's precise specifications. The site also allows the addition of text to any image, with more than 200 fonts with which to write special messages, personalized captions, and high-level cryptography.
                         Because of their highly personal and customizable nature, Bagettes bags make excellent gifts for mothers, bridesmaids, and hobbyists who collect bags printed with images of other bags. The value of today's Groupon can also be applied toward the purchase of a more expensive bag. Additional shipping and handling charges may apply for upgrades.",
             :expires => 07/14/2011,
			 :location => "www.bagettes.com",
			 :company => "Baggettes"
           }
    Deal.create!(@attr)
  end
  describe "signup" do

    describe "failure" do
      
      it "should not make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => ""
          fill_in "Email",        :with => ""
          fill_in "Password",     :with => ""
          fill_in "Confirmation", :with => ""
          click_button
          response.should render_template('users/new')
          response.should have_selector("div#error_explanation")
        end.should_not change(User, :count)
      end
    end
    describe "success" do

      it "should make a new user" do
        lambda do
          visit signup_path
          fill_in "Name",         :with => "Example User"
          fill_in "Email",        :with => "user@example.com"
          fill_in "Password",     :with => "foobar"
          fill_in "Confirmation", :with => "foobar"
          click_button
          response.should have_selector("div.flash.success",
                                        :content => "Welcome")
          response.should render_template('/')
        end.should change(User, :count).by(1)
      end
    end
  end

  describe "sign in/out" do

    describe "failure" do
      it "should not sign a user in" do
        visit signin_path
        fill_in :email,    :with => ""
        fill_in :password, :with => ""
        click_button
        response.should have_selector("div.flash.error", :content => "Invalid")
      end
    end

    describe "success" do
      it "should sign a user in and out" do
        user = Factory(:user)
        visit signin_path
        fill_in :email,    :with => user.email
        fill_in :password, :with => user.password
        click_button
        controller.should be_signed_in
        click_link "Sign out"
        controller.should_not be_signed_in
      end
    end
  end
end

