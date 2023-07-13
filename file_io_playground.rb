# All the pacakges that deal with IO try to maintain object oriented fashion of operation, and live in the standard (rather that core) library, so you have to import
# Largely ruby provides wrappers around system library calls with some enhancements and modifications
# A lot of this is wrappers around C calls

# IO Class, these represent connections to readable or writable things like files on disk or keyboard inputs
# you send messages to the IO class, it executes some C and gives you back the results

p STDERR.class # IO
STDERR.puts('Problem!!!!') # Problem!!!!
STDERR.write("Problem \n") # Problem, returns the number of bytes written

# Constants like STDERR, STDIN and STDOUT are auto set when the program starts up
# IO objects mix in Enumerable
# You can use gets and puts to get and put strings
# x = gets
# puts x

# Basic file operations
# File is a subclass of IO

file = File.new('./file_playground.txt')
p file.read # "hello world", this reads in the ENTIRE file as a single string, can be very memory intensive
file.close

# Line based file reading
file = File.new('./file_playground.txt')
p file.gets # read line at a time, you want to do gets cause it does not error out if you try to read past the end of the file, but rather returns a nil
p file.gets # read line at a time, you want to do gets cause it does not error out if you try to read past the end of the file, but rather returns a nil
p file.gets # read line at a time, you want to do gets cause it does not error out if you try to read past the end of the file, but rather returns a nil
p file.gets # read line at a time, you want to do gets cause it does not error out if you try to read past the end of the file, but rather returns a nil

# you can use rewind to move the file handle back to the beginning of the file
# and then use rewind
file.rewind # rewind to the beginning
p file.readlines # read all the lines to the end and return them as an array, can also be very inefficient

# Since this is enumerable, we can do the following:
file.rewind
file.each {|line| puts "The next line is #{line}"} # The next line is hello world The next line is hi there The next line is I am another line

file.close

# When trying to write to a file, you can use a w or an a methods of writing. w will replace file contents, a will append to existing file contents.
new_file = File.new('file_write_playgournd.txt', 'w')
new_file.puts('hello world')
new_file.puts('hi there')
new_file.puts('I am a line')
new_file.close

read_in_information = File.read('file_write_playgournd.txt') # Read ensures file is closed before returning
p read_in_information

# Using blocks for file operations
# If you call File.open with a code block, the block gets the file object as an argument to the block, and when the block ends the file handle gets released
File.open('file_write_playgournd.txt') {|file_handle| 
  file_handle.each {|line| p line.chomp} # "hello world\n", "hi there\n", "I am a line\n" chomp removes the new line char
} # handle auto released

File.open('members.txt') { |handle|
  _, _, average = handle.inject([0, 0, 0]) {|(count, total, average), line|
    count += 1
    lines = line.split # will auto split with a space char
    total += lines[1].to_i
    [count, total, total / count]
  }

  p "Average is #{average}"
}

# Some common file errors
# Errno::EACCES - no access, Errno::ENOENT - no such file exists, Errno::ISDIR - is a directory not a file etc

# Getting some meta data about the files
p File.size('members.txt') # 25 bytes
# Other metadata stuff you can do with files in Ruby

p FileTest.exist?('members.txt') # true
p FileTest.directory?('members.txt') # false
p FileTest.symlink?('members.txt') # false

p FileTest.readable?('members.txt') # true
p FileTest.writable?('members.txt') # true

p FileTest.zero?('members.txt') # is it zero bytes?, false

# Directory manupulation with the Dir class
# Reading the directory can be done in one of two ways: 
# 1. Entries - will show hidden files
# 2. Globbing - will NOT show hidden files. Globbing allows for wildcard matching and recursing matching in subdirectories.
dir = Dir.new('.') # make a dir object with the current directory.
p dir.entries # [".", "..", "array_playground.rb", "objects_methods.rb", "members.txt", "hash_playground.rb", "private_playground.rb", "date_time_playground.rb", "enumerable_playground.rb", "file_io_playground.rb", "numerical_objects.rb", "strings_and_symbols.rb", "error_handling.rb", "enumerator_playground.rb", "self_playground.rb", "string_playground.rb", "ranges.rb", "missing_methods.rb", "control_flow.rb", ".gitignore", "regex_playground.rb", "file_write_playgournd.txt", "comparable_playground.rb", "file_playground.txt", ".git", ".vscode", "set_playground.rb"
p Dir.entries('.') # another way to get the entries, same result as above

p Dir.glob('*.txt') # ["members.txt", "file_write_playgournd.txt", "file_playground.txt"] globs the current directory
p Dir['*.txt'] # ["members.txt", "file_write_playgournd.txt", "file_playground.txt"] same globbing, but u can't give it flag arguments

# Another interesting example in the file io is being able to read from the web via open-uri
require 'open-uri'
rubypage = URI.open('http://rubycentral.org')
puts rubypage.gets # <!DOCTYPE html> just the first line
puts rubypage.read # the whole document
rubypage.close # don't forget to close the handle


