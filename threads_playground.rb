# Threads in ruby are sort of like time shares, you still have a single thread running, but it can 
# switch contexts and do other things while its waiting.
# Ruby will try to use the OS native threading facilities, but will fall back to `green` threads (those defined by the ruby interpreter)
Thread.new {
  p 'Starting the thread' # printed second
  sleep(1)
  p 'at the end of the thread' # will never be seen
}
p 'Outside the thread' # Printed first

thread = Thread.new {
  p 'Starting the thread' # printed second
  sleep(1)
  p 'at the end of the thread' # will now be printed!! Third
}
p 'Outside the thread' # Printed first
thread.join # this is how you block and wait for threads to finish before moving on to the next line of code

p 'Trying to read in some files...'
t = Thread.new {
  (0..2).each do |n|
    begin
      File.open("part0#{n}") do |f|
        text << f.readlines
      end
    rescue Errno::ENOENT
      p "Message from thread, failed on n=#{n}" # "Message from thread, failed on n=0"
      Thread.exit
    end
  end
}

t.join
p 'Finished!!!' # "Finished!!!"

# Fibers are a twist on threads, they are re-entrant code blocks that can yeild back and forth with their calling context multiple times

f = Fiber.new {
  p 'I am doing some long running pre-work'
  Fiber.yield
  p 'I am doing some long running work after the work is done'
  Fiber.yield
  p 'I am doing some post validation work'
}

f.resume
p 'Does some logging to slack that pre-work has finished'
f.resume
p 'Do some more logging to slack that after work has finished'
f.resume
p 'Do some loggign to slack that validation work has finished'

