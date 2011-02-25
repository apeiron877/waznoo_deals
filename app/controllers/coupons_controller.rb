class CouponsController < ApplicationController
  before_filter :must_be_signed_in
  before_filter :must_be_admin_user, :except => [:index, :show]
  
  
  # show the page for creating a deal
  def new
    @title = "Create a new coupon"
    @coupon = Coupon.new
  end
  
  # used when we need to change a deal that's already in the system
  def edit
    @title = "Edit coupon"
    @coupon = Coupon.find_by_id(params[:id])
  end
  
  # use this to create a new deal
  def create
	@coupon = Coupon.new(params[:coupon])
	if @coupon.save
	    flash[:success] = "Coupon saved to database"
        redirect_to coupons_path
	else
		@title = "Create a new coupon"
		render 'new'
	end
  end

  # we want to show to current deal on the homepage by passing in
  # the current date
  def show
    @coupon = Coupon.find_by_id(params[:id])
    if not current_user.can_use?(@coupon)
      @coupon = nil
      end
  end

  # the action of editing a deal, ie pushing a change to the database
  def update
	@coupon = Coupon.find_by_id(params[:id])
    if @coupon.update_attributes(params[:coupon])
      flash[:success] = "Coupon updated."
      redirect_to coupons_path
    else
      @title = "Edit coupon"
      render 'edit'
    end
  end
  
  # we can use index to show a sampling of previous deals
  # implement that later
  def index
    @title = "All coupons"
    @coupons = Array.new
    Coupon.find(:all, :order => "created_at").each do |item|
      @coupons << item
    end
    #@coupons = Coupon.all.sort! { :created_at }
    #@coupons_pag = Coupon.paginate( :page => params[:page])
  end

  # this really shouldn't ever be called in production, since we want a 
  # record of all deals ever offered.
  def destroy
    Coupon.find(params[:id]).destroy
    flash[:success] = "Coupon destroyed."
    redirect_to coupons_path
  end
    
  

  private
  
  


end
