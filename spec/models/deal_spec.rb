require 'spec_helper'

describe Deal do
  before(:each) do
    @attr = { :name => "$19 for Medium-Sized, Personalized Bagguettes
						Photo Bag ($41 Value)", 
			  :price => 1700,
			  :value => 4100,
			  :starting_date => "01/10/2011",
			  :days_available => 5,
			  :num_available => 200,
			  :num_purchased => 138,
			  :num_needed_to_unlock => 15,
			  :blurb => "Without a stylish cosmetic bag, women are forced to wear beer helmets of lip gloss and bandoleers of mascara. Enjoy fashion and function with today's Groupon: for $19, today's deal gets you a personalized, medium-sized cosmetic bag from Bagettes ($41 value including shipping).
                         Bagettes allows customers to personalize their bags by incorporating their own photos and text into the design. Constructed from satin fabric and featuring a black nylon lining, the medium cosmetic bag is 8x5, giving it the volume to handle makeup, toiletries, and several hamsters. Images are embedded into the fibers of the bags rather than applied superficially to the surface, helping prevent fading and peeling over time and making the bags practical and durable ways to preserve special moments and to broadcast hilarious personal slogans. Images, from endearing shots of family members and pets to psychedelic portraiture of famous flightless birds, are submitted using the Bagettes website and can be cropped, resized, and rotated to fit the customer's precise specifications. The site also allows the addition of text to any image, with more than 200 fonts with which to write special messages, personalized captions, and high-level cryptography.
                         Because of their highly personal and customizable nature, Bagettes bags make excellent gifts for mothers, bridesmaids, and hobbyists who collect bags printed with images of other bags. The value of today's Groupon can also be applied toward the purchase of a more expensive bag. Additional shipping and handling charges may apply for upgrades.",
             :expires => "07/14/2011",
			 :location => "www.bagettes.com",
			 :company => "Baggettes"
             }

  end
  it "should create a new instance given valid attributes" do
    Deal.create!(@attr)
  end
  it "should require a name" do
    no_name_deal = Deal.new(@attr.merge(:name => ""))
    no_name_deal.should_not be_valid
  end
  it "should require a price" do
    no_price_deal =  Deal.new(@attr.merge(:price => nil))
    no_price_deal.should_not be_valid
  end
  it "should reject names that are too long" do
    long_name = "a" * 150
    long_name_deal = Deal.new(@attr.merge(:name => long_name))
    long_name_deal.should_not be_valid
  end
  it "should reject duplicate names, starting_dates, and blurbs" do
    # Put a deal with given info into the database.
    Deal.create!(@attr)
    deal_with_duplicate_info = Deal.new(@attr)
    deal_with_duplicate_info.should_not be_valid
  end

 end
