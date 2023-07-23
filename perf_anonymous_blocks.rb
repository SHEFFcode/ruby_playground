require_relative 'perf_benchmark_tool'

class Thing
  def initialize(id)
    @data = 'x' * 1024 * 20
  end
end

def do_something
  1000.times {|i| Thing.new(i)}
end

def take_block(&block)
  block.call('args')
end

measure {
  take_block {do_something()}
}

# {"gc":"enabled","time":0.01,"gc_count":2,"memory":"22 MB"}

def take_anon_block
  yield('args')
end

measure {
  take_anon_block {do_something()}
}

# {"gc":"enabled","time":0.01,"gc_count":1,"memory":"7 MB"} way better memory footprint