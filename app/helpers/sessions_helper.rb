module SessionsHelper

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.salt]
    self.current_user = user
  end
  
  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def must_be_signed_in
      deny_access(:signin, signin_path) unless signed_in?
  end
  
  def cant_be_signed_in
      deny_access(:signout, root_path) if signed_in?
  end
  
  def must_be_correct_user
      @user = User.find(params[:id])
      deny_access(:correct_user, root_path) unless current_user?(@user)
  end

  def must_be_admin_user
    if not signed_in?
	  deny_access(:signin, signin_path)
    else
      deny_access(:admin, root_path) unless current_user.admin?
    end
  end
    
  def deny_access(message, path)
	if message == :signin
		notice = "Please sign in to access that page."
	elsif message == :signout
		notice = "Please sign out to access that page."
	elsif message == :correct_user
		notice = "You don't have permission to access that page."
	elsif message == :admin
		notice = "Only administrators can access that page."
	end
    store_location
    redirect_to path, :notice => notice
  end
  
  # returns true if the input user is the logged in user
  def current_user?(user) 
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  # sets the input user to the current user
  def current_user=(user)
    @current_user = user
  end
  
  #returns true if a user is logged in
  def signed_in?
    !current_user.nil?
  end

  # if the current user local var is nil, set it to the user from the cookie
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  # Finds the correct deal to display for the current day
  def todays_deal
    date = Date.today
	deal = Deal.find_by_starting_date(date_as_string(Date.today))
    if deal.nil? or deal == 0  # this only happens if we don't use do a new deal every day.
		#find the most recent deal that started before today
		days_passed = 0
		while deal.nil? or deal == 0 do
		  date = date.yesterday 
		  deal = Deal.find_by_starting_date(date_as_string(date)) #See if there was a deal offered the day before today, before yesterday, etc
		  days_passed += 1 
		  if days_passed > 365
			flash.now[:notice] = "there haven't been any deals for over a year...?"
			return nil # return a nil deal
		  end
		end
		if (deal.days_available-1) < days_passed #the last deal is not still active
		  flash.now[:error] = "Previous deal started: #{date} and ran for #{deal.days_available} days. So it's no longer available!"
		  return nil # return a nil deal
		else
	      flash.now[:success] = "Previous deal started: #{date} and runs for #{deal.days_available} days. So it's still available!"
		  return deal #return active deal
	    end
	else
	    return deal #return today's deal
	end
  end
	
  def date_as_string(date)
	if date.month > 9
		if date.day > 9
			return "#{date.month}/#{date.day}/#{date.year}"
		else
			return "#{date.month}/0#{date.day}/#{date.year}"
		end
	else
		if date.day > 9
			return "0#{date.month}/#{date.day}/#{date.year}"
		else
			return "0#{date.month}/0#{date.day}/#{date.year}"
		end
	end
  end
  		
  private

    def user_from_remember_token
      User.authenticate_with_salt(*remember_token)
    end

    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
    
    def store_location
      session[:return_to] = request.fullpath
    end

    def clear_return_to
      session[:return_to] = nil
    end

    
end
