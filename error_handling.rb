# An exception is a special kind of object that is an instance of class Exception or a descendant of that class
# Raising an exception stops the flow of the program and and either deals with the issue, or exits the program completely

# Types of common exceptions:
# RuntimeError - Default exception raised by the raise method
# NoMethodError - an object was sent a message it can't resolve a method name
# NameError - interpreter hits an identifier taht it cannot resolve as a variable or a method name
# IOError - Caused by reading a closed stream, writing to a read only stream, and similar operation
# Errno::error - Family of errors that relates to file io
# TypeError - a method receives an argument it can't handle
# ArgumentError - using the wrong number of arguments

# rescue block is how you deal with errors

print 'Enter a number'
n = 0
begin
  result = 100 / n
rescue ZeroDivisionError => e
  puts "Your number did not work, was it is zero? Error was: #{e}"
end

puts "100 / #{n} is #{result}"

# You can rescue exceptions in blocks and function definitions

def open_user_file
  print "File to open"
  filename = 'hello.txt' # Does not exist
  
  fh = File.open(filename) # open for use
  yield fh # give to the block to do what it wants
  fh.close # close after use
  rescue # Here the rescue is in the func definition, and will catch any error in the above code
    puts "Coudln't open the file!!"
end

def open_user_file_better_way
  print "File to open"
  filename = 'hello.txt' # Does not exist
  begin # better to define an area you are trying to guard and not be over eager
    fh = File.open(filename) # open for use
    yield fh # give to the block to do what it wants
    fh.close # close after use
  rescue # Here the rescue is in the func definition, and will catch any error in the above code
    puts "Coudln't open the file!!"
  end
end


open_user_file {|f| f.print}
open_user_file_better_way {|f| f.print}


# Raising exceptions in ruby
# use the raise keyword and the name of the exception you would like to raise

def fussy_method(x)
  raise ArgumentError, 'I need a number under 10' unless x < 10 # while you are raising a class, you are really raising ArgumentError.new or an instance of the class
end

begin # let's be safe here
  fussy_method(20)
rescue ArgumentError => e
  p "That was not an acceptible number!! #{e}"
  p e.backtrace # add the backtrace
  p e.message # add the message
  # If you want you can re-raise the exception you caught here by just saying raise, which by default will re-raise the same exception it caught
end

# Ensure

def line_from_file(filename, substring)
  fh = File.open(filename)

  begin
    line = fh.gets
    raise ArgumentError unless line.include?(substring)
  rescue ArgumentError
    puts 'Invalid line!!'
    raise # even though we re-raise, the ensure block will still happen
  ensure
    fh.close() # here we can make sure that the file handle gets closed not matter what
  end
  return line
end

# Creating your own exceptions
class InvalidLineError < StandardError
end

def line_from_file_custom_error(filename, substring)
  fh = File.open(filename)

  begin
    line = fh.gets
    raise InvalidLineError, 'Invalid line!' unless line.include?(substring)
  rescue InvalidLineError => e # much better description here
    puts 'Invalid line!!'
    p e.message
    raise # even though we re-raise, the ensure block will still happen
  ensure
    fh.close() # here we can make sure that the file handle gets closed not matter what
  end
  return line
end

# Exceptions are classes, classes are constants and constants can be namespaced in ruby i.e. Something::SomethingException







