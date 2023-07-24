require 'bigdecimal'
require_relative './perf_benchmark_tool'

def heavy_function
  Array.new(100_000) {BigDecimal(rand(), 3)}.inject(0) {|sum, i| sum + i}
end

measure {
  result = heavy_function
}

# {"gc":"enabled","time":0.28,"gc_count":60,"memory":"19 MB"}


measure {
  read, write = IO.pipe
  pid = fork do 
    read.close
    result = heavy_function
    Marshal.dump(result, write)

    exit!(0)
  end

  write.close
  result = read.read
  Process.wait(pid) # 0.5000663328586e5, here we got a result

  puts Marshal.load(result).inspect
}
# {"gc":"enabled","time":0.29,"gc_count":1,"memory":"-2 MB"} we are actually not wasting any memory at all
# Sidekiq actually uses threads and as the object space grows, the whole process will need to restart.

