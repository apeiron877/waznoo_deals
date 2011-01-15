class Order < ActiveRecord::Base
	belongs_to :user
	has_many :order_transactions
	
	attr_accessor :card_number,  :card_verification
	
	validate(:validate_card, :on => :create)
	
	
	def purchase 
	  price = todays_deal.price
	  response = GATEWAY.purchase(price, credit_card, :ip => ip_address)
	  OrderTransaction.create!(:action => "purchase", :amount => price, 
						   :response => response)
	  response.success?
	
	end
	
	private
	
	def validate_card
	  unless credit_card.valid?
		credit_card.errors.full_messages.each do |message|
		  errors.add_to_base(message)
		end
	  end
	end
	
	def credit_card
	  @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
	    :type				=> card_type,
	    :number				=> card_number,
	    :verification_value => card_verification,
	    :month				=> card_expires_on.month,
	    :year				=> card_expires_on.year,
	    :first_name			=> first_name,
	    :last_name			=> last_name
		)
	end
	
end
