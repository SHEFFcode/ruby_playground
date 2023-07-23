require_relative './perf_benchmark_tool'

data = Array.new(100) {'x' * 1024 * 1024} # 100 MB or so array

measure {
  data.map {|str| str.upcase}
}
# {"gc":"enabled","time":0.07,"gc_count":4,"memory":"100 MB"}

other_array =  Array.new(100) {'x' * 1024 * 1024} # 100 MB or so array

measure {
  data.map!{|str| str.upcase!}
}
# {"gc":"enabled","time":0.09,"gc_count":1,"memory":"0 MB"}