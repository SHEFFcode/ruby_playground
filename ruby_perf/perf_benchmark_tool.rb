require 'json'
require 'benchmark'

def measure(&block)
  no_gc = (ARGV[0] == '--no-gc')

  if no_gc
    GC.disable
  else
    # Collect the memory loaded during library loading
    # before measurment
    GC.start
  end

  memory_before = `ps -o rss= -p #{Process.pid}`.to_i / 1024
  gc_stat_before = GC.stat
  time = Benchmark.realtime do
    yield
  end

  # p ObjectSpace.count_objects

  unless no_gc
    GC.start(full_mark: true, immediate_sweep: true, immediate_mark: false)
  end

  # p ObjectSpace.count_objects

  gc_stat_after = GC.stat

  memory_after = `ps -o rss= -p #{Process.pid}`.to_i / 1024

  puts({
    gc: no_gc ? 'disabled' : 'enabled',
    time: time.round(2),
    gc_count: gc_stat_after[:count] - gc_stat_before[:count],
    memory: "#{memory_after - memory_before} MB"
  }.to_json)
end
