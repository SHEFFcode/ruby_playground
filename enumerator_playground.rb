# Enumerators are basically generators in other languages, they are able to yield values based on some pre-defined formula
# They are then able to do the monad operations on the yeilded values

# How to define an Enumerator
e = Enumerator.new {|yielder| #  note you can't do yield here, it will not work in ruby :(
  (1..3).each {|idx| yielder << "This is numer #{idx}"}
}

e.each{|i| p i} # "This is numer 1", "This is numer 2", "This is numer 3", in theory generator can keep going forever


# Enumerator is able to un-override a method, it always calls the Enumerable's methods, rather than any overrides that might exist like in a hash
# Enumerator serves as a gateway to a collection, that allows read only acess, but not a modification access
# Enumerators track their state, and can start and stop their enumerations. They are also great for infinate sequences
# In ruby enumerators allow you to rewind them
names = %w{David Yukihiro}
e = names.to_enum # to enumerator
p e.next # David
p e.next # Yukihiro
e.rewind
p e.next # David, we have rewound!!!

# Iterator is a method, does not have state. Enumerator (Generator) is an object that keeps state and uses iterator to advance

# Enumerator method chaining
names = %w{Josh Steve Paul Topolsky}
p "The result of chaining is #{names.select {|n| n.chars.first < 'M'}.map(&:upcase).join(', ')}" # "The result of chaining is JOSH", the only one whose name starts with less than M
# Another useful enumeration
names = %w{ Josh Topolsky Paul Miller Nilay Patel}
p "The result of slices is first and last names: #{names.each_slice(2).map {|first, last| first.capitalize + last.capitalize}}" # "The result of slices is first and last names: [\"JoshTopolsky\", \"PaulMiller\", \"NilayPatel\"]"

# Indexing enumerables with index
p ('a'..'z').map.with_index {|letter, idx| {letter => idx}} # [{"a"=>0}, {"b"=>1}, {"c"=>2}, {"d"=>3}, {"e"=>4}, {"f"=>5}, {"g"=>6}, {"h"=>7}, {"i"=>8}, {"j"=>9}, {"k"=>10}, {"l"=>11}, {"m"=>12}, {"n"=>13}, {"o"=>14}, {"p"=>15}, {"q"=>16}, {"r"=>17}, {"s"=>18}, {"t"=>19}, {"u"=>20}, {"v"=>21}, {"w"=>22}, {"x"=>23}, {"y"=>24}, {"z"=>25}]
p ('a'..'z').map.with_index(1) {|letter, idx| {letter => idx}} # with offset here [{"a"=>1}, {"b"=>2}, {"c"=>3}, {"d"=>4}, {"e"=>5}, {"f"=>6}, {"g"=>7}, {"h"=>8}, {"i"=>9}, {"j"=>10}, {"k"=>11}, {"l"=>12}, {"m"=>13}, {"n"=>14}, {"o"=>15}, {"p"=>16}, {"q"=>17}, {"r"=>18}, {"s"=>19}, {"t"=>20}, {"u"=>21}, {"v"=>22}, {"w"=>23}, {"x"=>24}, {"y"=>25}, {"z"=>26}]

# Lazy enumerators
# p (1..Float::INFINITY).select{|n| n % 3 == 0}.first(10) # never executes, you are stuck in an infinate loop here, DO NOT ATTEMP
# But you can make this lazy
p (1..Float::INFINITY).lazy.select{|n| n % 3 == 0}.first(10) # happily runs on an infinate collection [3, 6, 9, 12, 15, 18, 21, 24, 27, 30]

# Use this for fizzbuzz calculator
def fb_calc(i)
  case 0
  when i % 15
    'FizzBuzz'
  when i % 3
    'Fizz'
  when i % 5
    'Buzz'
  else
    i.to_s
  end
end

def fb(n)
  p (1..Float::INFINITY).lazy.map{|i| fb_calc(i)}.first(n) # take first n items with fizz buzz applied to it
end

fb(5) # first 5 fizz buzz numbers: ["1", "2", "Fizz", "4", "Buzz"]

