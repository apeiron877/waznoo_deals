class CouponsController < ApplicationController
  before_filter :must_be_signed_in
  before_filter :must_be_admin_user, :except => [:index, :show]
  
  
  # show the page for creating a coupon
  def new
    @title = "Create a new coupon"
    @coupon = Coupon.new
  end
  
  # used when we need to change a coupon that's already in the system
  def edit
    @title = "Edit coupon"
    @coupon = Coupon.find_by_id(params[:id])
  end
  
  # use this to create a new coupon
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

  # we want to show the selected coupon
  def show
    @coupon = Coupon.find_by_id(params[:id])
    if current_user.days_until_available(@coupon) > 0
      @coupon = nil
    else
      current_user.use_coupon!(@coupon)
    end
  end

  # the action of editing a coupon, ie pushing a change to the database
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
  
  # we can use index to show all coupons
  def index
    @title = "All coupons"
    @coupons = Array.new
    Coupon.find(:all, :order => "created_at").each do |item|
      @coupons << item
    end
    #@coupons = Coupon.all.sort! { :created_at }
    #@coupons_pag = Coupon.paginate( :page => params[:page])
  end

  # to delete a coupon
  def destroy
    Coupon.find(params[:id]).destroy
    flash[:success] = "Coupon destroyed."
    redirect_to coupons_path
  end
    
  

  private
  
  


end
