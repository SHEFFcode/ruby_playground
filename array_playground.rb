# Array.new constructor
p Array.new(3) # [nil, nil, nil]
p Array.new(3, 'abc') # ["abc", "abc", "abc"]
p Array.new(3) { |idx|
  idx += 1
  idx * 10
} # [10, 20, 30]

# Array literal consutrctor
arr = []
p arr # []
p [1, 2, 'hello', true, []]

# Through a to_a method on an object
s = 'A string'
p s.respond_to?('to_ary') # False, typecasting method of converting to array
p s.respond_to?('to_a') # False
p Array(s) # ['A string'] Basically will wrap the object into an array

p Integer('1') # 1, is another way to do this
# p Integer('1abc') # Error
p '1abc'.to_i # 1, non fussy version of the Integer method above

# Other cool ways of creating an array
p %w{ hello friends} # ["hello", "friends"], but each one is looked at as a ginle quoted string, so interpolation
p %W{ hello #{x = 'friends'} } # ["hello", "friends"], but we got here through interpolation
p %w{ 1 2 3 } # ["1", "2", "3"] this is always an array of strings

# i is an array of symbols
p %i{ hello friends } # [:hello, :friends]

# Arrays are numerically ordered, any object you try to add goes to the end of the array
a = []
a[0] = 0
p a

# Working with multiple items in the square brackets
# arr[3, 2] = ['a', 'b'] here the first argument is the position 0 based index, and second argument is length (# of items)

a = %w{ red orange yellow purple gray indigo violet }
p a # ["red", "orange", "yellow", "purple", "gray", "indigo", "violet"]
p a[3, 2] # ["purple", "gray"], this is similar to calling slice on the array
a[3, 2] = %w{ green, blue } #
p a # ["red", "orange", "yellow", "green,", "blue", "indigo", "violet"]
p "What if we overshoot #{a[3, 20]}" # "What if we overshoot [\"green,\", \"blue\", \"indigo\", \"violet\"]", safe goes to the end
p "What if we overshoot another way #{a[19, 20]}" # "What if we overshoot another way ", safe returns nil

# Values at method
a = %w{ the dog ate the cat }
articles = a.values_at(0, 3) # that items at the indexes provided
p articles # ["the", "the"]
p a.values_at(0, 50) # ["the", nil], let's see what happens if you overshoot

# Methods for operating on beginings and ends of arrays in ruby
a = [1, 2, 3, 4]
a.unshift(0) # [0, 1, 2, 3, 4] Will put 0 in the front of the array, might be performant on average, but worst case still O(n)
p a

a = [1, 2, 3, 4]
a.push(5) # will add at the end of the array, very inexpensive unless array needs to be resized
p a # [1, 2, 3, 4, 5]
# You can also use a shovel to do the same thing
a << 6 # we will shovel in a 6 at the end. The benefit of push is that it can take more than 1 argument, while shovel cannot
p a # [1, 2, 3, 4, 5, 6]

# There are corresponding shift and pop methods, of which shift is the expensive one
a.shift # removes the first element, might be performant on average.
p a # [2, 3, 4, 5, 6]
a.pop # removes from the end, pretty performant
p a # [2, 3, 4, 5]

# Combining arrays with other arrays
a = [1, 2, 3]
p a.concat([4, 5, 6]) # [1, 2, 3, 4, 5, 6], changes actual array in place
# p a.concat(4, 5, 6) # No good, will thrown an error
p a # array is changed in place [1, 2, 3, 4, 5, 6]

a = [1, 2, 3]
p a.push([4, 5, 6]) # [1, 2, 3, [4, 5, 6]], array changed in place
p a # [1, 2, 3, [4, 5, 6]]

a = [1, 2, 3]
p a + [4, 5, 6] # [1, 2, 3, 4, 5, 6]
p a # [1, 2, 3] array is not changed in place


a = [1, 2, 3]
p a.replace([4]) # [4], replaces in place, the original array object is retained, just the contents are changed
 
# There is also a way to unnest an array
a = [1, 2, [3, 4, [5], 6, [7, 8]]]
p a
p a.flatten # full flatten [1, 2, 3, 4, 5, 6, 7, 8]
p a # retains original values  [1, 2, [3, 4, [5], 6, [7, 8]]]

p a.flatten(1) # will only do one level of flattening [1, 2, 3, 4, [5], 6, [7, 8]]
p a  # [1, 2, [3, 4, [5], 6, [7, 8]]]

# You can also join elements of an array into a string
a = ['abc', 'edf', 123].join
p a # "abcedf123"

# Another way to do a join
a = %w{one two three}
p a * '-' # "one-two-three"
p a # ["one", "two", "three"], original not modified

# You can also get a de-duped array
a = [1, 2, 3, 3, 4, 5, 5, 6]
p a.uniq # [1, 2, 3, 4, 5, 6], duplicate status is determined using the == method
p a # [1, 2, 3, 3, 4, 5, 5, 6] not in place

# You can also remove nil values using compact
a = ['06511', '08902', '08902', nil, '', '10027']
p a
p a.compact # ["06511", "08902", "08902", "", "10027"], empty string is not removed, only nils not in place

# Querying the array
a = [1, 2, 3]
p a.size # 3
p a.length # 3, same as size
p a.empty? # false
p a.include?(1) # true
p a.count(1) # 1 occurance of 1 in the array
p a.first(2) # [1, 2] first 2 elements in the array
p a.last(1) # 3, the last element in the array

p a.count(235) # 0 occurances of 235 in the array
p a.first(1000) #  #[1, 2, 3] safe operation





