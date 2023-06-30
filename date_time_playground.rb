require 'date'
require 'time'

# To get todays date do the following
d = Date.today
p d.to_s

# Parsing is actually pretty good
p Date.parse('November 2 2013').to_s
p Date.parse('Nov 2 2013').to_s
p Date.parse('2 Nov 2013').to_s
p Date.parse('2013/11/2').to_s

# Time objects
p Time.new
p Time.at(10000000)
p Time.mktime(2007, 10, 3, 14, 3, 6)
p Time.parse('March 22, 1985, 10:35 PM') # pretty cool

# Date/Time Objects
p DateTime.new(2009, 1, 2, 3, 4, 5)
p DateTime.now
p DateTime.parse('October 23, 1973, 10:34 PM') # really cool, prides a bit more detail than time class alone

# Querying date/time objects

dt = DateTime.now
p dt.year
p dt.hour
p dt.minute
p dt.min # same as minute
p dt.sec # same as second
p dt.second
p dt.day # 30th, which is the 30th of june 2023

p dt.monday? # false 
p dt.sunday? # false, really cool methods

# Date/Time arithmetic

# Time
# You can add and subtract seconds from time

t = Time.now
p t # 2023-06-30 15:53:54.924985 -0500
p t - 20 # 2023-06-30 15:53:34.924985 -0500
p t + 20 # 2023-06-30 15:54:14.924985 -0500

# Date Time
# You can add days to datetime with + or -, and months with << or >> operators
dt = DateTime.now
p dt # 2023-06-30T15:55:38-05:00
p dt + 100 # 2023-10-08T15:55:38-05:00, adds 100 days
p dt >> 3 # 2023-09-30T15:55:38-05:00, adds 3 months

# Dates

d = Date.today
p d
p d.next # next day
p d.next_year
p d.prev_day

# Iterating over a range of dates
d = Date.today
next_week = d + 7
d.upto(next_week) { |date| 
  puts "#{date} is a #{date.strftime("%A")}"
}
