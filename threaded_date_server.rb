# require 'socket'
# s = TCPServer.new(3939)
# while true do
#   conn = s.accept
#   conn.puts 'Hi what is your name?'
#   name = conn.gets.chomp
#   sleep(5) # simulate a long running request here, see that the second client gets nothing back!
#   conn.puts "Hi #{name}. Here is the date."
#   conn.puts `date` # the backticks are sort of like an eval command
#   conn.close
# end
# # s.close

# Now a better server

require 'socket'
s = TCPServer.new(3939)
while (conn = s.accept)
  Thread.new(conn) do |connection_in_thread| # Each time you get a new connection 
    connection_in_thread.print "Hi. What is your name?"
    sleep(5) # simulate a long running request here, see that the second client gets nothing back!
    name = connection_in_thread.gets.chomp
    connection_in_thread.puts "Hi #{name}, today's date is #{`date`}"
    connection_in_thread.close
  end
end