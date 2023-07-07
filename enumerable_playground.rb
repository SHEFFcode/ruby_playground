# Getting the first match with find
arr = [1, 2, 3, 4, 5, 6, 7, 8, 8, 9, 10]
p arr.find {|n| n > 5} # 6, finds the first match and stops
p arr.find(lambda {'not found'}) {|n| n > 10} # find takes a lambda of what to do if value in block is not found

# Get all matches with find_all
p arr.find_all {|n| n > 5} # [6, 7, 8, 8, 9, 10]
p arr.select {|n| n > 5} # [6, 7, 8, 8, 9, 10], basically a synonym for find_all
p arr.reject {|n| n > 5} # [1, 2, 3, 4, 5], inverse operation

# grep expressions
colors = %w{red orange yellow green blue indigo violet}
p colors.grep(/o/) # based on a regex, ["orange", "yellow", "indigo", "violet"]
misc = [75, 'yellow', 10..20, 'goodbye'] # array with random things in it
p misc.grep(String) # ["yellow", "goodbye"], gets all the strings
p misc.grep(50..100) # [75] gets all the numbers in range
p misc.grep(String) {|item| item.capitalize} # ["Yellow", "Goodbye"], items found by grep will be passed to the block

# group by
colors = %w{red orange yellow green blue indigo violet}
p colors.group_by{|color| color.size} # {3=>["red"], 6=>["orange", "yellow", "indigo", "violet"], 5=>["green"], 4=>["blue"]} groups by length
p colors.group_by(&:size) # {3=>["red"], 6=>["orange", "yellow", "indigo", "violet"], 5=>["green"], 4=>["blue"]} groups by length

# All enumerables have a first method, but not all of them have a last method, except for arrays and ranges
range = 0..10
p range.first # 0
p range.last # 10

# Take and drop methods
states = %W{NJ NY CT MA VT FL}
p states.take(2)  # ["NJ", "NY"]
p states.drop(2)  # ["CT", "MA", "VT", "FL"]

# Min and max methods, these are determined by the <=> spaceship operator
arr = [1, 2, 3, 4]
p arr.min # 1
p arr.max # 4

# Relatives of each
arr = [1, 2, 3]
arr.reverse_each {|n| p n} # 3, 2, 1, prints in reverse order

# Each with index method
names = %w{GeorgeWashington JohnAdams ThommasJefferson}
names.each_with_index { |pres, i|
  p "#{pres} was the #{i} presedent" # "GeorgeWashington was the 0 presedent", "JohnAdams was the 1 presedent", "ThommasJefferson was the 2 presedent" etc
}

# each_slice and each_cons methods
array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
array.each_slice(3) {|slice| p slice}  # [[1, 2, 3], [4, 5, 6], [7, 8, 9], [10]] you can see here subarrays of size at most 3
array.each_cons(3) {|consequtive_slice_of_size| p consequtive_slice_of_size} # [[1, 2, 3], [2, 3, 4], [3, 4, 5], [4, 5, 6], [5, 6, 7], [6, 7, 8], [7, 8, 9], [8, 9, 10]] consequetive sequences of size 3

# Enumerable reduction (fold left) via inject method, which is the same as fold left
arr = [1, 2, 3, 4]
res = arr.inject(0) { |acc, num|
  acc + num # basic fold left sum operation
}
p res # res is 10 (1 + 2 + 3 + 4) = 10

# map
# We know how map operats, its one of the monad operators, the interesting thing with ruby is the map! bang operator, which returns arra modified in place
names = %W{Josh Jeremy Leora}
p names.map(&:upcase) # ["JOSH", "JEREMY", "LEORA"]
p names # arr not modified ["Josh", "Jeremy", "Leora"]

p names.map!(&:upcase) # ["JOSH", "JEREMY", "LEORA"]
p names # arr is modified ["JOSH", "JEREMY", "LEORA"]

# Cool string iterators
s = 'abcde'
s.each_byte {|b| p b} # 97, 98, 99, 100, 101
s.each_char {|c| p c} # "a", "b", "c", "d", "e"
p s.chars # will print an array of chars of the string, ["a", "b", "c", "d", "e"]

# You can also print out each line
many_lines = "This string\nhas three\nlines."
many_lines.each_line {|l| puts l} # This string, has three, lines.

# Sorting, for sorting you object does not need to be an Enumerable, only to define the spaceship operator (has a comparator defined)
arr = [3, 2, 5, 4, 1]
p arr.sort # returns a new arr of elements, original is untouched, [1, 2, 3, 4, 5]
p arr # [3, 2, 5, 4, 1]
p arr.sort! # returns an arra of elements permanently sorted, [1, 2, 3, 4, 5]
p arr # [1, 2, 3, 4, 5], changed in place

# You can also define the sorting function in the block
arr = [3, 2, 5, 4, 1] # original unsorted
p "I am sorting via space ship #{arr.sort(&:<=>)}"  # "I am sorting via space ship [1, 2, 3, 4, 5]"
p "I am sorting via code block spaceship #{arr.sort{|a, b| a <=> b}}" # "I am sorting via code block spaceship [1, 2, 3, 4, 5]"

# Another way to do sorting
arr = %w{2 1.5 3 4 6}
p arr.sort {|a, b| a.to_f <=> b.to_f} # ["1.5", "2", "3", "4", "6"]
# a shorter version
p arr.sort_by {|item| item.to_f} # ["1.5", "2", "3", "4", "6"], basically a shortcut for the above


