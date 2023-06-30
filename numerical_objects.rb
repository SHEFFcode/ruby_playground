# Numbers are objects, you can send messages to them like any other object.

n = 99.6 # you are a float
p n.round # 100

x = 12
p x.zero? # false

# Numeric is the top class for all numers descend from it
# Integers and Floats are the 2 main branches for Numeric class
# Integers can be fixnum and bignum, bigbum can store more data, and conversion is handled automatically

# Note that integer division always produces an integer (is rounded, if you want a non rounded result you need to convert to float by adding .0 at the end)

p 3/2 # 1!
p 3.0/2 # 1.5
p 3/2.0 # 1.5

# Arithmatic operators are actually methods with synthactic sugar and can be called like this

p 3.0./(2) # 1.5

