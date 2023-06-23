p Kernel.private_instance_methods.sort # where all the helper methods live like quire and print

def use_me
  p 'use me'
end

class Person
  def say_something
    p 'I am about to say use me'
    use_me()
  end
end


person = Person.new

person.say_something

person.use_me() # will not work, because use_me is defined as a private var on Object, and usages with explicit caller should be decliend. "private method `use_me'"