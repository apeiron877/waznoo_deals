require "rubygems"
require "active_merchant"

ActiveMerchant::Billing::Base.mode = :test

  gateway = ActiveMerchant::Billing::PaypalGateway.new(
	:login => "prosel_1295043078_biz_api1.mymail.pomona.edu",
	:password => "1295043089",
	:signature => "Ab7YzWTiowt0BHf-Ktne5j.KCvXXAqtvnJ6nJMS0Mnr8VKZ7iV0WjT-h"
  )
  
  credit_card = ActiveMerchant::Billing::CreditCard.new(
  	:type => "visa",
  	:number => "4024007148673576",
  	:verification_value => "123",
  	:month => 1,
  	:year => 2012,
  	:first_name => "Ryan",
  	:last_name => "Bates"
  	)
  	
  if credit_card.valid?
    response = gateway.authorize(1000, credit_card, :ip => "127.0.0.1")
    if response.success?
    	puts "Purchase complete."
    	gateway.capture(1000, response.authorization)
    else 
      puts "Error: #{response.message}"
    end 
  else
    puts "Error: Credit card is not valid. #{credit_card.errors.full_messages.join('. ')}"
  end
  
  # gateway.void()
  # gateway.credit returns funds
