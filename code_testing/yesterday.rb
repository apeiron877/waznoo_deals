#!/usr/bin/ruby
=begin
def previous_day(date)
    day = date[3,4].to_i
	if day != 1	#if it's not the first of the month
	  yesterday = day.pred
          return "#{date[0,1]}#{"/"}#{yesterday}#{"/"}#{date[6,7,8,9]}"
	else
		month = date[0,1].to_i
		year = date[6,7,8,9].to_i
		if month == 2 or month == 4 or month == 6 or month  == 8 or
		   month == 9 or month == 11
		     last_month = month.pred
		     yesterday = 31
		elsif month == 1
		     last_month = 12
   		     yesterday = 31
   		     year = year.pred
		elsif month == 5 or month == 7 or month == 10 or month == 12
			 last_month = month.pred
			 yesterday = 30
	    elsif month == 3
			last_month = 2
			if ( year % 400 == 0 ) or (year % 4 == 0 and year % 100 != 0)
				yesterday = 29
			else 
				yesterday = 28
			end
		end
          return "#{last_month}#{"/"}#{yesterday}#{"/"}#{year.to_s}"
	end
  end
puts previous_day("04292010")
=end
sum = 0
for i in 14..1000 do
  if (i%5 == 0) and (i%3 == 0)
	sum += i
  end
end
 
 puts sum
