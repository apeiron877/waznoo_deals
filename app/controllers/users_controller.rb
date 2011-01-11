class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :index]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => [ :index, :destroy ]
  
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

    def authenticate
      deny_access unless signed_in?
    end

	def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      if current_user.nil?
		deny_access
	  else
      must_be_admin unless current_user.admin?
      end
    end

  
end


