# Hash can be created a in few different ways

hash_a = {'IL' => 'Illinois'}
p hash_a['IL'] # "Illinois"

hash_b = {IL: 'Illinois'} # looks a lot like JSON
p hash_b[:IL] # with a symbol
p hash_b['IL'] # nil this will not work with a string accessor, there is no 'with_indifferent_access' in pure ruby, this is a rails construct

# Hashes remember the insertion order of the keys, so for example
hash_c = {}
hash_c['IL'] = 'Illinois'
hash_c['FL'] = 'Florida'
hash_c.each.with_index { |(k, v), idx|
  p k, v, idx # IL, Illinois, 0; FL, florida, 1;
}

# Creating a new hash is best with literal constructor
h = {}

# You can use Hash.new, and if you provide a constructor it will be the default value if key is not present
h = Hash.new('Not here')
p h[:hello] # "Not here"

# Another way to make a hash is via the shortcut method with even number of items in an array
h = Hash['IL', 'Illinois', 'CA', 'California'] # if you do an odd number of items, you will get a fatal error
p h # {"IL"=>"Illinois", "CA"=>"California"}
# You can also do a nested array
h = Hash[ [['IL', 'Illinois'], ['CA', 'California']] ] # to be more explicit, note that there is the outer [] for notation, and inner [[], []] for items
p h 

# ANother way to add things to a hash
h = {}
h.store('IL', 'Illinois')
p h  # {"IL"=>"Illinois"}

p h.fetch('IL') # this is an alternative to h['il']
h.store('CA', 'California')
p h.values_at('IL', 'CA') # ["Illinois", "California"]
p h.fetch_values('IL', 'CA') # ["Illinois", "California"]

# If you want to provide a way that a new key value pair is made when a non existant key is asked for you can do like this
remembering_hash = Hash.new { |hash, key| hash[key] = 0 } # every time a new item is requested, if its not there it will be set to 0
p remembering_hash # {}
remembering_hash['c']
p remembering_hash # {"c"=>0}, can be useful for char counting

# Combining hashes with other hashes
# There are 2 ways to combine hashes:
# Destructive - where elements of the first hash are overriden if the same key exists in the second hash via update method
h1 = Hash['Smith', 'John', 'Jones', 'Jane']
h2 = Hash['Smith', 'Jim']
h1.update(h2)
p h1 # you can see this was destructive, Smith is now Jim
# Non Destructive - where a third hash is created, leaving the original unchanged via the merge method
h1 = Hash['Smith', 'John', 'Jones', 'Jane']
h2 = Hash['Smith', 'Jim']
h3 = h1.merge(h2) # , merge with a ! is a synanym for update
p h3 # {"Smith"=>"Jim", "Jones"=>"Jane"}
p h1 # {"Smith"=>"John", "Jones"=>"Jane"}, you can see the original remains unchanged

# Hash Transformations

# Selecting and Rejecting elements from a hash
h = Hash[1, 2, 3, 4, 5, 6]
p h.select {|k, v| k > 1} # {3=>4, 5=>6}, filered out the items less than 2, non destructive
# Rejecting works in the opposite direction
p h.reject {|k, v| k > 1} # {1=>2}

# Inverting a hash
# This operations turns keys into values and vice versa
h = Hash[1, 'One', 2, 'Two']
p h # {1=>"One", 2=>"Two"}
p h.invert # {"One"=>1, "Two"=>2}, non destructive
p h # {1=>"One", 2=>"Two"}

# Be careful when inverting, because if there are the same values for different keys, you will have information loss as there can be 
# no duplicate keys in a hash

# Clearing a hash
h = Hash[1, 2]
p h # {1=>2}
p h.clear # {}, destructive by definition
p h # {}

p h = {a: '2', b: '3'} # {:a=>"2", :b=>"3"}
p h.replace(({a: 3, b: 22})) # {:a=>3, :b=>22}

# Querying hashes
h = Hash[1, 2, 3, 4,] # {1=>2, 3=>4}, ending comma is ignored
p h

p h.has_key?(3) # True
p h.include?(3) # true
p h.empty? # false
p h.size # 2, 2 key value pairs

# Hashes as final method argumetns
class City
  attr_accessor :name, :state, :population
end

def add_to_city_database(city_name, info)
  c = City.new
  c.name = city_name
  c.state = info[:state]
  c.population = info[:population]
  c
end

city = add_to_city_database('Chicago', state: 'IL', population: 2.7) # Notice that trailing arguments will be bunched up as a hash called info
p city # #<City:0x00007fdbdc861c70 @name="Chicago", @state="IL", @population=2.7>
# It is best not to pass a hash as the first argument, otherwise you need to basically put the whole thing in parens, etc
# This is basically similar to named or keyword arguments

# Let's look at named arguments
def m(a:, b:) # this synthax also means that the arguments are required
  p a, b
end
m(b:2, a: 1) # 1, 2 position does not matter, because we have named arguments

def m(a: 1, b: 2)
  p a, b
end

m() # 1, 2
m(a: 3)  # 3, 2
m(a: 3, b: 4) # 3, 4 
# m(3, 4) # will not work, does not assume positional arguments are same as named ones, all named ones must be passed in

def my_method(param, *args, a: 1, b: 2, **kwargs) # this will sponge up any unkown arguments
  p param, args, a, b, kwargs
end

my_method(1, 2, 3, 4, a: 1, b:2, x: 3, z: 4) # 1, [2, 3, 4], 1, 2, {:x=>3, :z=>4}




