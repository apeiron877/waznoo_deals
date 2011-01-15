class OrdersController < ApplicationController
  before_filter :must_be_signed_in
  
  
  # show the page for creating a deal
  def new
    @order = Order.new
  end
  
  def create
    @order = current_user.build_order(params[:order])
    @order.ip_address = request.remote_ip
    if @order.save
		if @order.purchase
		  render :action => 'success'
		else
		  render :action => 'failure'
		end
    else
		  render :action => 'new'
    end
  end
  
  
end
