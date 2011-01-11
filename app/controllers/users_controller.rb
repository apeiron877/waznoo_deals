class UsersController < ApplicationController
  
  def new
    @title = "Sign up"
    @user = User.new
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
  end

end

