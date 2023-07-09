# Basic regular expression in Ruby is similar to other languages, it has a literal constrictor of //
p //.class # Regexp
p /abc/.match('The alphabet starts with abc.') #<MatchData "abc">
data = /abc/.match('The alphabet starts with abc.')
p data.public_methods(false)
p data.to_a # ["abc"]
p data.pre_match # The alphabet starts with 
p data.post_match # .

# There is a match method available on both the regex and the string class, but if you call it on a string you will convert the string to a regex first
p /abc/.match('The alphabet starts with abc.') # No conversions are done, result is #<MatchData "abc">
p 'The alphabet starts with abc.'.match(/abc/) # the string here is converted to a regex first, result is #<MatchData "abc">

# There is another way to check for matches, which will give you the lations of the first match
p /abc/ =~ 'hi abc bye abc' # 3, location of the first match
data = /abc/.match('hi abc bye abc')
p data
p data.pre_match # "hi ", only the first match counts
p data.post_match # " bye abc", only the first match counts
p data.size # 1

# There is also a way to just get yes/no answer if there is a match by adding a ?
p /abc/.match?('abc') # true

# Literal characters in patterns
/a/ # will match literal character 'a'
/\?/ # this is how you will need to match a question mark, because otherwise it's a special char in regex
# Here is a list of all the special characters in regex: %w[^$?./\[]{}()+*]

# The . character will match any single character at some point in your pattern. Matches any char except new line char.
# To match both rejected and dejected you can do as follows
p /.ejected/.match?('rejected') # true
p /.ejected/.match?('dejected') # true

# Character classes are explicit list of characters that are placed inside the regex in square brackets []
p /[dr]ejected/.match?('rejected') # true
p /[dr]ejected/.match?('dejected') # true
# If you want to do a range of chars, you can use a dash
/[a-z]/ # any char from a to z
/[a-z]ejected/.match?('pejected') # true

# To do a hex match, you can do as follows
p /[A-Fa-f0-9]/.match?('0') # true, either A-F or a-f or 0-9 for a single char
p /[A-Fa-f0-9]/.match?('a') # true
p /[A-Fa-f0-9]/.match?('B') # true

# Do do the inverse, you can put a charot at the start of a class of chars, like this for NOT hex
p /[^A-Fa-f0-9]/.match?('0') # not the items in the char class # true
p /[^A-Fa-f0-9]/.match?('x') # not the items in the char class # false
p /[^A-Fa-f0-9]/.match?('b') # not the items in the char class # true

# Find first occurance of non hex item
p /[^A-Fa-f0-9]/ =~ 'ABC3934 is a hex number' # 7, space is the first non hex char!

# Special ways to select char classes
# If you want only digits 0-9 you can do this
p /[0-9]/ =~ '3' # 0th position match
# BUT you can also do this
p /\d/ =~ '3' # 0th position match, so \d is the same is 0-9

# \w matches any alpha char and an underscore _
# \s matches any whitespace char, space, tab, newline

# If you want to do a negated form, you can do as follows
# \D anything that is not a digit
# \W anything that is not alpha
# \S anything that is not a space

# Match data objects
# Imagine your input is as follows: Peel,Emma,Mrs.,talanted amateur (basically a CSV)
# Let's match this pattern:
regex = /[A-Za-z]+,[A-Za-z]+,Mrs.?\./ # so alpha chars, then comma, then alpha chars, then comma, then either Mr or Mrs (question mark denoted 0 or 1 occurances), then a period.
regex2 = /\w+,\w+,Mrs.?\./ # so alpha chars, then comma, then alpha chars, then comma, then either Mr or Mrs (question mark denoted 0 or 1 occurances), then a period.
p regex.match('Peel,Emma,Mrs.,talanted amateur') # #<MatchData "Peel,Emma,Mrs.">
p regex2.match('Peel,Emma,Mrs.,talanted amateur') # #<MatchData "Peel,Emma,Mrs.">

# Now let's create 2 groupings, one around last name, and one around the mr / mrs
regex3 = /(\w+),\w+,(Mrs.?)\./ # now we have 2 groups, one around \w and one around Mrs?
p regex3.match('Peel,Emma,Mrs.,talanted amateur') # #<MatchData "Peel,Emma,Mrs." 1:"Peel" 2:"Mrs">

# Let's look at a more complex example
string = 'My phone number is (123) 867-5309'
phone_re = /\((\d{3})\)\s+(\d{3})-(\d{4})/ # so we have a 3 part match, ( opening parens, then a group of 3 digits and a ) closing parens, then one more more space chars, then 3 digits, then a dash -, then 4 digits
m = phone_re.match(string) # let's match it
unless m 
  p 'There was no match'
end

p "The whole string we started with was #{m[0]}" # m[0] basically gives you the orignial string that you were matching against
p "The three captures are"
m.captures.each_with_index {|capture, idx| p "Capture ##{idx + 1}: #{capture}"} # Print all 3 captures: "Capture #1: 123", "Capture #2: 867", "Capture #3: 5309"
p "Another way to get the first capture is #{m[1]}" # m[1] gives you first capture, copared to m[0] which gives the original string, "Another way to get the first capture is 123"

# To figure out which thing will be matched first, count parantheses from the left, and the first one to open will be the first match, second will be second etc
# consider this
p /((a)((b)c))/.match('abc') #<MatchData "abc" 1:"abc" 2:"a" 3:"bc" 4:"b">

# Named captures
re = /(?<first>\w+)\s+((?<middle>\w\.)\s+)?(?<last>\w+)/ # Trying to capture David A. Black here
m = re.match('David A. Black') #<MatchData "David A. Black" first:"David" middle:"A." last:"Black">
p m  #<MatchData "David A. Black" first:"David" middle:"A." last:"Black">
p m[:first] # "David"
p m.begin(:first) # 0 began at 0th char
p m.end(:first) # 5 ended at 5th char

# You can also refer to match data via global var of $~ (dollar tilda)
p $~ # #<MatchData "David A. Black" first:"David" middle:"A." last:"Black">, most recent regex match data, can be used even if you used =~ operator

# Match qualifiers, you can specify how many times you want a mtach to occur
# Zero or one occurance of a char - ? question mark is 0 or 1 occurance of a char
re = /Mrs?/ # s is optional here
p re =~ ('Mrs') # 0, at position 0
p re =~ ('Mr') # 0, at position 0

p 'Number 0 is truthy' if re =~ 'Mr' # "Number 0 is truthy"

# * (star or splat) means 0 or more occurances, for example
re = /\s*hello\s*/
p re.match('        hello        ') #<MatchData "        hello        ">
p re.match('hello')  #<MatchData "hello">

# one more more qualifier is +
re = /hey+/
p re.match('hey') #<MatchData "hey">
p re.match('heyyyyyyyyyyyy') #<MatchData "heyyyyyyyyyyyy">

# Greedy vs non greedy qualifiers
re = /\d+/
p re.match('12345') # + and * are greedy, will keep grabbing items #<MatchData "12345">

# Specific number of repetitiions
re = /(\d{3}-(\d{4}))/ # 3 digits followed by dash followed by 4 digits
p re.match '867-5309' # #<MatchData "867-5309" 1:"867-5309" 2:"5309">

# Anchors are ^ begining of the line and $ for end of the line
comment_re = /^\s*#/ # basically here you are saying that you want any number of spaces followed by a # sign to signify that you have a pure commnet
p comment_re.match '# pure comment' # #<MatchData "#">
p comment_re.match 'x = 5 # I am a comment and wont be matched' # nil

# Positive lookaheads are (?=...), negative look aheads are (?!...) so if you want to match only if digits end in a . you do /\d+(?=\.)/

# There are also look behind assertions, which are (?<=...) and (?<!...) respectively

# Modifiers
# i modifiers in //i means that the regex will be case insensetive
# /m modifier means that it can be multiline, so that the wildcard * will match new line char as well
# x modifier will ignore whitespace in the regex unless it is escaped with a \
# You can do string like #{} interpolation inside the regex as well
chars = 'abc'
re = /#{chars}/
p re.match 'abc' # #<MatchData "abc"

# === operator (case equality or membership operator) for a regex is the match method, so re === 'somestring' is same as re.match 'somestring'


