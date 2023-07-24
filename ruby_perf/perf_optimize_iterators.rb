require_relative './perf_benchmark_tool'

# optimize iterators by freeying up objects during iteration
class Thing 
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end # basic lass definition

measure {
  list = Array.new(100_000) {|idx| Thing.new(idx.to_s)} # make a few objects here

  list.each { |item|
    item.name = 'hello' # reassign the name
  }
}
# {"gc":"enabled","time":0.04,"gc_count":8,"memory":"15 MB"}

measure {
  list = Array.new(100_000) {|idx| Thing.new(idx.to_s)} # make a few objects here

  while list.count < 0
    item.name = 'hello' # reassign the name
    list.shift # surprisingly this is implemented as a dequeue in ruby, so an O(1) op
  end
}
# {"gc":"enabled","time":0.02,"gc_count":2,"memory":"4 MB"} way faster and less memory, so for larger items this makes a lot of sense.

# The above can be done via the each! method, which can be implemented as follows
class Array
  def each!
    while count > 0
      yield(shift)
    end
  end
end

measure {
  list = Array.new(100_000) {|idx| Thing.new(idx.to_s)} # make a few objects here

  list.each!{ |item|
    item.name = 'hello'
  }
}
# {"gc":"enabled","time":0.03,"gc_count":3,"memory":"5 MB"}, slightly worse for memory, but still plenty fast
