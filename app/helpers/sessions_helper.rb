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
		notice = "Please sign in to access this page."
	elsif message == :signout
		notice = "Please sign out to access this page."
	elsif message == :correct_user
		notice = "You don't have permission to access this page."
	elsif message == :admin
		notice = "Only administrators can access this page."
	end
    store_location
    redirect_to path, :notice => notice
  end
  
  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def current_user=(user)
    @current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= user_from_remember_token
  end
  
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
			break
		  end
		end
		
	    if deal.days_available < days_passed #the last deal is not still active
		  flash.now[:error] = "Previous deal started: #{date} and ran for #{deal.days_available} days. So it's no longer available!"
		  return nil
		else
	      flash.now[:success] = "Previous deal started: #{date} and runs for #{deal.days_available} days. So it's still available!"
		  return deal
	    end
	  else
	    return deal
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
  		
  				 
  # finds the date (xx/xx/xxxx) immediately prior to the supplied date
  #def previous_day(date)
  #  day = date[3,4].to_i
	#if day != 1	#if it's not the first of the month
	#  yesterday = day.pred
    #      return "#{date[0,1]}#{"/"}#{yesterday}#{"/"}#{date[6,7,8,9]}"
	#else
	#	month = date[0,1].to_i
#		year = date[6,7,8,9].to_i
#		if month == 2 or month == 4 or month == 6 or month  == 8 or
#			 month == 9 or month == 11
#		     last_month = month.pred
#		     yesterday = 31
#		elsif month == 1
#		     last_month = 12
 #  		     yesterday = 31
  # 		     year = year.pred
#		elsif month == 5 or month == 7 or month == 10 or month == 12
#			 last_month = month.pred
#			 yesterday = 30
#	    elsif month == 3
#			last_month = 2
#			if ( year % 400 == 0 ) or (year % 4 == 0 and year % 100 != 0)
#				yesterday = 29
#			else 
#				yesterday = 28
#			end
#		end
 #         return "#{last_month}#{"/"}#{yesterday}#{"/"}#{year.to_s}"
#	end
#  end




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
