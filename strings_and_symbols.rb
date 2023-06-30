# scalar means one dementional, which means its not a collection of things
# String interpolation only works in double quoted strings

# Some other ways to produce strings
p %q{Hello don't need to escape ' ' here} # another way to do strings
p %Q{No need to escape " " here}

# Here docs, are here in a sense that they are not read in from the file
# EOM is common ending, but can be any character or sequence of characters
# EOM is end of message and is used for convention
# << has to be flush (without space) to the EOM
# It keeps the spacing from left in its output
# EOM has to be flush left to end the heredoc, if u dont want it to be 
# u can add a -EOM to it, then it does not have to be flush left
text = <<EOM
Hello friends
  I am a here doc
EOM

p text

# Weirdly you can also do the following in heredoc
a = <<EOM.to_i * 10
5
EOM

p a # this is 50!!!!

# Getting a char
s = 'Ruby is a cool language'

p s[5]
p s[-12] # you can do negative numbers as well

# To get a subtring you do 2 chart
p s[5, 10]

# You can also use ranges
p s[5..10] # this is inclusive of the last item
# vs
p s[5...10] # this is exclusive of the last item, which is a bit counter intuitive

p s[-12..20] # can also do negative numbers

# You can also see if a substring is in a string by doing the following
p s['cool lang'] # 'cool lang'
p s['very cool lang'] # nil, which is a cool shortcut to check existance of a substring in str


p s.slice!('cool') # bang means permanent modification
p s # Ruby is a  language


s = 'Ruby is a cool language'
s['cool'] = 'great' # pretty cool synthax
p s # ruby is a great language

# Adding strings together without modding them is just the + sign

s1 = 'hello'
s2 = 'world'
p s1 + s2
s3 = ''
s3 << s1 + s2 # here we shovel in, paranthesis are not required
p s3

p s.include?('Ruby')
p s.include?('ruby') # false
p s.start_with?('Ruby')
p s.start_with?('ruby') # false
p s.empty? # false
p s.size
p s.count('a')
p s.count('g-m') # you can provide a letter range
p s.count('A-Z') # this range is for capital letters only
p s.count('aey. ') # the occurance of 'a', 'e', 'y', '.' or ' '. (Sum of those occurances)

p 'a'.ord() # gives back the ordinal code (97)
p 97.chr # 'a'

p 'a' == 97 # false
p 'a' == 97.chr # true

# String comparisons
p 'b' > 'a' # true
p 'a' > 'A' # true

p 'a'.ord, 'A'.ord # 97, 65

# The == method tests for equality of the content of the two strings in question

p 'a' == 'a' # true, note here that 'a'.eql? is basically the same as ==
p 'a'.equal? 'a' # false because they are not the same object


# String transformations
s = 'David A. Black'
p s.upcase # "DAVID A. BLACK"
p s.downcase # "david a. black"
p s.swapcase # "dAVID a. bLACK"
p s.capitalize # David a. black, so only the first letter will be capitalized

p 'The Middle'.center(20, '*') # "*****The Middle*****"

p '      the center        '.strip # "the center"
p "Some line \n".chomp # removes the new line by default, if given an argument will try to remove it if its there

p s = '(to be named later)' # dont want it to be named anything yet
p s.replace('Hello world')

p __ENCODING__ # how to see what encoding you are using, by default UTF-8