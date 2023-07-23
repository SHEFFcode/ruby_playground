require_relative './perf_benchmark_tool'
require 'csv'

measure {
  File.read('perf_data.csv')
}
# {"gc":"enabled","time":0.0,"gc_count":1,"memory":"6 MB"}, exactly the amount of memory of the underlying file

# Things are about to get worse as you try to parse the file
# for example split it into an array of arrays that represent the lines
measure {
  File.readlines('perf_data.csv').map! {|line| line.split(',')}
}
# {"gc":"enabled","time":0.08,"gc_count":10,"memory":"44 MB"} over 7x the memory!!!

# Things will get somewhat better with CSV.read, but you pay the price for in runtime
measure {
  CSV.read('perf_data.csv')
}
# {"gc":"enabled","time":0.35,"gc_count":5,"memory":"13 MB"} I guess the garbage collection has been improved quite a bit

# So what can be done?
# Read and parse data in files line by line as much as possible
measure {
  lines = []
  File.open('perf_data.csv') { |file|
    while line = file.gets
      lines << line.split(',')
    end
  }
}
# {"gc":"enabled","time":0.08,"gc_count":3,"memory":"8 MB"}, look at that, performance and runtime are sort of uneffected

# You can also do this with CSV itself:
measure {
  lines = []
  CSV.open('perf_data.csv') { |csv|
    while line = csv.readline
      lines << line
    end
  }
}
# {"gc":"enabled","time":0.34,"gc_count":7,"memory":"6 MB"}, again does not improve the runtime, but improves the memore consuption quite a bit
