# A range is an object with a start and an end point
# 2 key concepts - inclusion (wheather or not an item is in range), enumeration - range is a collection of traversible individual items

r = 1..100 # you just made a range
p r# 1..100, this means the range is inclusive of the last number supplied

# You can think of the range as including whatever is there after the second dot
# So 1..(100) insludes the 100, while 1..(.)100 the number right before 100 is in the range

# Range inclusion logic
r = 1..10
p r.begin # 1
p r.end # 10
p r.exclude_end? # false will it exclude the last item

# Inclusion tests
r = 'a'..'z'
p r.cover?('a') # true
p r.cover?('m') # true
p r.cover?('z') # true
p r.cover?('A') # false
p r.cover?('abc') # true, 'a' <= 'abc' <= 'z' so these are done using comparison ops

# Cover is different from include?, include treats the range is a pseudo collection
# So let's see this
p r.cover?('abc') # true
p r.include?('abc') # false

# Where you cannot look at the range as a finite collection, it include will fallback to cover
r = 1.0..2.0
p r.include?(1.5) # true not a finite collection, but 1.0 <= 1.5 <= 2.0 so this will return true

# Negative ranges
a = %w{a b c d}
p a[0..-2] # ["a", "b", "c"] from 0th item to 2d from the back inclusive
p a[0...-2] # ["a", "b"] from 0th item to 2d from the back exclusive
