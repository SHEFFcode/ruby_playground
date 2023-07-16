t = Thread.new {
  Thread.current[:message] = 'Hello'
}
t.join
p t.keys # array of key symbols, [:message]
p t[:message] # "Hello"