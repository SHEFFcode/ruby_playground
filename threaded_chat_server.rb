require 'socket'
def welcome(chatter)
  chatter.print 'Welcome! Please enter your name:'
  chatter.readline.chomp
end

def broadcast(message, chatters)
  chatters.each {|chatter| chatter.puts(message)}
end

s = TCPServer.new(3939)
chatters = []

while (chatter = s.accept)
  Thread.new(chatter) do |c|
    name = welcome(chatter)
    broadcast("#{name} has joined", chatters)
    chatters << chatter
    begin
      loop {
        line = c.readline
        broadcast("#{name}: #{line}", chatters)
      }

    rescue EOFError
      c.close
      chatters.delete(c)
      broadcast("#{name} has left", chatters)
    end
  end
end

