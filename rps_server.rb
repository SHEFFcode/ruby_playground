require 'socket'
require_relative 'rock_paper_scizzors'

s = TCPServer.new(3939)
threads = []
2.times { |n|
  conn = s.accept
  threads << Thread.new(conn) { |c|
    Thread.current[:number] = n + 1 
    Thread.current[:player] = c
    c.puts "Welcome player #{n + 1}"
    c.print "Your move? (rock, paper, scissors)"
    Thread.current[:move] = c.gets.chomp
    c.puts "Thanks! Hang on..."
  }
}

a, b = threads
a.join
b.join
rps1, rps2 = Games::RPS.new(a[:move]), Games::RPS.new(b[:move])
winner = rps1.play(rps2)
if winner
  result = winner.move
else
  result = 'Tie!'
end

threads.each { |t|
  t[:player].puts "The winner is #{result}"
}