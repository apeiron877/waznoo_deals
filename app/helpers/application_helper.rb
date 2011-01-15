module ApplicationHelper

  # Return a title on a per-page basis.
  def title
    base_title = "WaznooDeals!"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
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
	#		flash.now[:notice] = "there haven't been any deals for over a year...?"
			return nil # return a nil deal
		  end
		end
		if (deal.days_available-1) < days_passed #the last deal is not still active
	#	  flash.now[:error] = "Previous deal started: #{date} and ran for #{deal.days_available} days. So it's no longer available!"
		  return nil # return a nil deal
		else
	 #     flash.now[:success] = "Previous deal started: #{date} and runs for #{deal.days_available} days. So it's still available!"
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

