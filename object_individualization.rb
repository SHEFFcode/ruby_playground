# In ruby each object can have singleton methods assigned to it that give it functionality different from the initial class it was created with.
# Here is an example of a singleton methods:

class Cat
  def meow
    p 'meow'
  end
end

cat = Cat.new
cat.meow # this will meow
# now let's give it a different method here
def cat.bark
  p 'woof' # our instance of cat can now bark!
end

cat.bark # "woof"

cat2 = Cat.new # cat2 can only do things a Cat can, but it cannot bark
# cat2.bark # undefined method `bark' for #<Cat:0x00007faf62856150> (NoMethodError)

# Another interesting tid bit, is that the class methods are also singleton methods
class Cat # classes can be reopened
  def self.think_about_life # this self method is a singleton method on a Cat class object (cause classes are objects and what not)
    p 'I am thinking about life'
  end
end

Cat.think_about_life # this is not possible, "I am thinking about life"

# Every ruby object has 2 classes, the class it was made from, and its singleton class. This is similar to Scala's companion object
# To get to the singleton object of a specific object, you do the following:

cat3 = Cat.new
class << cat3 # we are not modifying the singleton object of the cat3 object!
  def lick_yourself
    p 'I am cat licking myself.'
  end
end

cat3.lick_yourself # "I am cat licking myself.", super cool

# So what's different between class << cat3 and def cat.something? The answer is that constants are resolved differently
# you can define your own constants inside the class definition that will take presedence over the ones in outer scope.
# You can also use the << notation to define class methods

class Ticket
  class << self # this is adding a method to the Ticket class's singleton object which is a class method in a way
    def most_expensive(*tickets)
      tickets.max_by(&:price)
    end
  end
  
  attr_accessor :price

  def initialize(price)
    @price = price
  end
end

ticket1 = Ticket.new(10)
ticket2 = Ticket.new(20)
p Ticket.most_expensive(ticket1, ticket2)

# Singleton classes in the method-lookup path
# Singleton class is first in line in the method look up path
# So it would be any modules prepended to the singleton class, the class itself, and objects included in the singleton, and then up the inheritance chain of the class and any of its mixings up to the BasicObject

class Talker
  def talk
    p 'Hi from the original class!!'
  end
end

talker = Talker.new
talker.talk # "Hi from the original class!!"

module SuperTalker
  def talk
    p 'Hello from the super talker!!'
  end
end

class << talker
  include SuperTalker # add the super talked to the instance object
  p ancestors # [#<Class:#<Talker:0x00007fe49a0ae3e0>>, SuperTalker, Talker, Object, Kernel, BasicObject]
end

talker.talk # "Hello from the super talker!!"
p talker.class.ancestors # will not show the module mixed in! [Talker, Object, Kernel, BasicObject]
p talker.singleton_class.ancestors # [#<Class:#<Talker:0x00007fafef892208>>, SuperTalker, Talker, Object, Kernel, BasicObject]


