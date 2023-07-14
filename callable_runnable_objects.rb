# The proc class - basic anonymous funnctions
# A callable object in Ruby is one to which u can send a call message and expect some code to run
# Main callable objects in ruby are:
# 1. Procs
# 2. lambdas
# 3. method objects

# Procs are self contained code sequences that you can execute
# Lambdas are similar to Procs and lambdas ARE procs but with special internal engineering
# Method objects are methods extracted into objects that you can them pass around

# Procs
my_proc = Proc.new {p 'I am calling to you from inside a proc'}
my_proc.call # "I am calling to you from inside a proc"

# You can also make a proce as follows
my_short_proc = proc {p 'I am a short form of proc'}
my_short_proc.call # "I am a short form of proc"

# & symbol turns a code block into a callable proc, see below

def call_a_block(&regular_block) # adding & to the block is the magic here, without it block wont be a block
  regular_block.call
end

call_a_block {p 'I am a regular block of code, I am not callable'} # "I am a regular block of code, I am not callable"

# def dont_call_a_block(block)
#   block.call # massive fail wrong number of arguments (given 0, expected 1) (ArgumentError)
# end

# dont_call_a_block {p 'I am a regular block of code, I am not callable'}

# Procs can also turn into regular blocks for methods that expect them, also with a & converstion symbol
print_me = proc {|x| p x}
[1,2,3].each(&print_me) # 1, 2, 3

# Code block is not an object, it is a part of the synthax of the method call
# There is no code block class, you can not assign a code block to an argument
# If you define the to_proc method on any object, you can then use the & synthax on it for proc <=> block onverstions

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def self.to_proc
    proc {|person| person.name}
  end
end

d = Person.new('David')
j = Person.new('Josh')
p [d, j].each(&Person) # kind of weird, but Person class object has a to_proc method, so this will work, [#<Person:0x00007f7b89137e08 @name="David">, #<Person:0x00007f7b89137d90 @name="Josh">]


# Using symbol to_proc for conciceness
p %w{david black}.map(&:capitalize) # ["David", "Black"], but how is this possible?
# this is equivalent to p %w{david black}.map(|name| name.send(:capitalize)) so this is basically just for conciseness

# Symbol has a special to_proc method:
class MySymbol
  def to_proc
    proc {|obj| obj.send(self)}
  end
end

# Procs crate closures, which preserve local variables that are in place at the time that a proc is created.
# This can help you with curring like this

def create_multiply_by_x(multiplier)
  proc {|value| value * multiplier}
end

# so now we can make a curried function
multiply_by_10 = create_multiply_by_x(10) # here we just made a proc that will remember 10 as its outer param no matter where it goes, you created a closure!!
p multiply_by_10.call(12) # 120, congrats you just called a curried function

def call_some_proc(pr)
  a = 'I am irrelevant'
  pr.call
end

a = 'I am the real a'
pr = proc {puts a}
call_some_proc(pr) # I am the real a, the one inside the method definition is irrelevant

def call_some_other_proc(pr2)
  b = 'I am irrelevant'
  pr2.call
end

# a = 'I am the real a'
# pr2 = proc {puts b}
# call_some_other_proc(pr2) # will error out, no b in scope, since b is not a param input the closure knows nothing about a param called b

# Lets make a counter

def make_counter
  n = 0
  proc { n += 1 }
end

counter = make_counter()
p counter.call # 1
p counter.call # 2, we maintain state in the background!!!

# Proc parameters and arguments
pr = Proc.new {|x| puts "Called with arguments #{x}"}
pr = Proc.new {|*x| puts "Called with arguments #{x.join(',')}"} # you can see you can be even more fancy here with arity in procs
pr.call(100)  # Called with argument 100

# If you call the proc with no argument, it gets passed in nil
pr.call # Called with argument 

# If you call with more than supported number of arguments, the remaining are discarded
pr.call(1, 2, 3, 4) # Called with argument 1

# Procs are less fussy about their arity (number of argumetns passed in)
# You can create fussier procs with lambdas