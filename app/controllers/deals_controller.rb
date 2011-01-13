class DealsController < ApplicationController
  before_filter :must_be_admin_user, :except => [ :show ]
  
  
  # show the page for creating a deal
  def new
    @title = "Create a new Deal"
    @deal = Deal.new
  end
  
  # used when we need to change a deal that's already in the system
  def edit
    @title = "Edit deal"
    @deal = Deal.find_by_id(params[:id])
  end
  
  # use this to create a new deal
  def create
	@deal = Deal.new(params[:deal])
	@deal.num_purchased = 0
	
		
	if @deal.save
	    flash[:success] = "Deal saved to database"
        redirect_to deals_path
	else
		@title = "Create a new Deal"
		render 'new'
	end
  end

  # we want to show to current deal on the homepage by passing in
  # the current date
  def show
   # if params[:starting_date] == today(Time.new)
    @deal = Deal.find(params[:id])
     @data_tables = ActiveRecord::Base.connection.tables
   # end
  end

  # the action of editing a deal, ie pushing a change to the database
  def update
	@deal = Deal.find_by_id(params[:id])
    if @deal.update_attributes(params[:deal])
      flash[:success] = "Deal updated."
      redirect_to deals_path
    else
      @title = "Edit deal"
      render 'edit'
    end
  end
  
  # we can use index to show a sampling of previous deal
  # implement that later
  def index
    @title = "All deals"
    @deals = Deal.paginate(:page => params[:page])
  end

  # this really shouldn't ever be called in production, since we want a 
  # record of all deals ever offered.
  def destroy
    Deal.find(params[:id]).destroy
    flash[:success] = "Deal destroyed."
    redirect_to deals_path
  end

  private
  
  
  


end
