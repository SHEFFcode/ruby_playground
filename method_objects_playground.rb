# You can get hold of an object's method by using the `method` function
class C 
  def talk
    puts "Method grabbing test! self is #{self}"
  end
end

c = C.new
meth = c.method(:talk) # This is a bound method, the method know that when u call it it will be bound to instane c
meth.call() # here the meth bound method becomes callable, so you get output Method grabbing test! self is #<C:0x00007ff0888ee7b8> bounc to instance of c

# You can also unbind the method, and bind it to a different object of the same class (or a subclass)
class D < C
end

d = D.new
unbound = meth.unbind # we will remove the binding
# unbound.call() # undefined method `call' for #<UnboundMethod:0x00007fe1520660b8> (NoMethodError)
unbound = unbound.bind(d) # will will now bind to a new instance
unbound.call() # Method grabbing test! self is #<D:0x00007fd48c922148>

# If you want to get the unbound method, you can do the following
unbound_c = C.instance_method(:talk) # we get the unbound talk method
# Now we can bind it to D
new_d = D.new
unbound_c = unbound_c.bind(new_d)
unbound_c.call  # Method grabbing test! self is #<D:0x00007f96ad8b5e20>

# So why might you want to do something like this
# You might want to go up the definition chain for example like this
class Aclass
  def a_method
    puts "Method defined in class A"
  end
end

class Bclass < Aclass
  def a_method # I am redefining here
    puts "Method defined in class B, which is a subclass of A"
  end
end

class Cclass < Bclass
end

c = Cclass.new
c.a_method # you will get the one from B, Method defined in class B, which is a subclass of A
Aclass.instance_method(:a_method).bind(c).call # Method defined in class A, all of the sudden we can do A's operations on instance of class C!!!

# Instead of using .call you can also use square brackets to call callable objects
a_class_method = Aclass.instance_method(:a_method).bind(c)
a_class_method[] # Method defined in class A this will call the callable method
a_class_method.() # this will also call it, but its a bit ugly, remember that omitting the dot will not work!