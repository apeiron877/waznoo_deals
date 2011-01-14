class UsersController < ApplicationController
  before_filter :must_be_signed_in, :except => [:new, :create]
  before_filter :must_be_correct_user, :only => [:show, :edit, :update]
  before_filter :must_be_admin_user, :only => [ :index, :destroy ]
  before_filter :cant_be_signed_in, :only => [:new, :create]
  
  def new
    @title = "Sign up"
    @user = User.new
  end
  
  def edit
    @title = "Settings"
  end
  
  def create
	@user = User.new(params[:user])
	if @user.save
	  sign_in @user
	  flash[:success] = "Welcome to Waznoo! Deals!"
      redirect_to root_path

	else
		@title = "Sign up"
		render 'new'
	end
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Settings updated."
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
   def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_path
  end

  
 
  private

    

	

  
end


