x = 5

x = 10 if x == 5 # this is a nifty structure

if x == 10 then p 'x = 10' end

unless x == 5 then p 'x is not 5 here' end # Generally you want to use the if logic rather than the unless logic

p x


class Ticket
  attr_accessor :venue, :date

  def initialize(venue, date)
    @venue = venue
    @date = date
  end

  # the triple equals is used by the case/when statemetns in ruby
  def ===(other_ticket)
    @venue == other_ticket.venue
  end
end

ticket1 = Ticket.new('Town Hall', '07/08/13')
ticket2 = Ticket.new('Conference Center', '07/08/13')
ticket3 = Ticket.new('Town Hall', '07/08/13')

case ticket1
when ticket2
  puts 'same location as ticket 2'
when ticket3
  puts 'Same location as ticket 3'
else
  puts 'no match'
end

# Case statements evaluate to a result


x = true
res = case
when x == true
  x
else
  false
end


p "res is #{res}" # You can see there is a result of the case expression



# Loops

n = 1
# Loop itself is implemented in C++, and is an iterator that calls the code block you pass in
loop do
  n = n + 1
  p "n is #{n}"
  break if n > 9
end


# While loop on rails

n = 0
while n < 11
  p n
  n += 1
end

p 'Done while looping!'


# You can also put while at the end of the end of the loop like so

n = 10
begin
  puts n
  n +=1 
end while n < 11
puts 'Done with while loop at the end' # Note that is executed once even though while condition is false.

# Until keyword

n = 1
until n > 10
  p n
  n += 1
end
p 'Done with until iteration'

# A shorter way to do the same thing

n = 1
n += 1 until n == 10
p "reached the end n is #{n}"

# Looping a list of values
celcius_values = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]

for c_v in celcius_values
  p "#{c_v} -> #{c_v * 9 / 5 + 32}"
end

#lt's not try to do loop in pure ruby, instead of using underlying C implementation
def my_loop
  while true
    yield # here is the yiled of the iterator
  end
end

# Anatomy of a method call in ruby
# A receiever object or variable (self if absent)
# A dot (required if there is an explicit receiver)
# A method name (required)
# An argument list (optional, defaults to empty list ())
# A code block (optional, there is no default), this is key, every method in theory has access to a block
# If you provide a block, the method can yield, if you do not, there is nothing to yield to
# Code blocks can be done via curly braces or a do/end keyword pair

arr = [1, 2, 3]
puts arr.map {|n| n * 10} # note that this will give u the result
puts arr.map do |n| n * 10 end # this will give you the enumerator, because it is interperted as puts arr.map, which is an Enumerator

res = 5.times {p 'Writing this 5 times!'} 
p "the result of 5.times is #{res}" # result is 5

# If we want to implement this ourselves we can do the following

class Integer # we are re-opening the already system defined integer class
  def my_times # defining a new method on it
    c = 0
    until c == self # self here will be 5 or whatever integer this is called on
      yield c # basically call block(c) which is what is happenig here, so is passed into the block
      c += 1 # we will incrememnt c here, and hold on to it, in the context of the until block
    end
    self # return self here, to match the system defiend version
  end
end

res = 5.my_times {|c| p "Writing this 5 times using my_times function!!!, and c was #{c}"} # as we can see the c is passed into the block
p "res of calling my_times function is #{res}"

# Each operation in ruby

arr = [1, 2, 3, 4, 5] # our og array
result = arr.each {|item| p "I got the following item from array #{item}"} # each returns a result, which is basically array itself
p "Result of calling each on an array is #{result}" # array itself

# How do we implement each
class Array
  def my_each
    c = 0
    until c == self.size
      yield(self[c]) # call the block with current item at index c
      c += 1
    end
    self # return the array itself
  end
end

my_arr = [1, 2, 3, 4, 5]
res = my_arr.my_each {|item| p "I got the following item using my_each #{item}"} # and the result is the array itself
p res

# Each vs map, each returns its receiver, map returns a new array

# Implement our own ma
class Array
  def my_map
    c = 0
    acc = [] # we need an accumulator to return
    until c == self.size
      acc << yield(self[c]) # pop into the accumulator the result of calling the block on the current element
      c += 1
    end
    acc # return the acc from the method
  end
end

my_arr = [1, 2, 3, 4, 5]
res = my_arr.my_map {|x| x * 2} # here we are looking for the modified result
p "res is #{res}" # the modified or mapped over array


# Block scope

# If you had a variable defined outside the block, the block will have access to it

def block_scope_demo
  x = 100
  1.times do 
    puts x
  end
end

block_scope_demo() # prints 100

def block_scope_demo_2
  x = 100
  1.times do
    x = 200
  end
  p x
end
block_scope_demo_2() # we can reassign existing variable inside the block, prints 200

# Blocks have direct access to variables that already exist
# However, if you creat a new block variable (inside the pipes), then it will be the one used in the block

def block_scope_demo_3
  x = 100
  y = 200
  1.times do |x|
    x = 500
    p "x inside the block is #{x}" # here is 500
    p "We still have access to y #{y}"
  end
  p "x outside the block is back to #{x}" # back to 100
end
block_scope_demo_3()

# There is also a concept of block params after the colon, which basically protects params that you want to be block local, but won't be passed in to the block
# This is to protect similarly names params outside the block

