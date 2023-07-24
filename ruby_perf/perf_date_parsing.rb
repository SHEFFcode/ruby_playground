require 'date'
require_relative 'perf_benchmark_tool'

date = '2023-07-23'

measure {
  100_000.times do 
    Date.parse(date)
  end
}
# {"gc":"enabled","time":0.28,"gc_count":116,"memory":"1 MB"}

measure {
  100_000.times do 
    Date.strptime(date, '%Y-%m-%d')
  end
}

# {"gc":"enabled","time":0.05,"gc_count":32,"memory":"1 MB"}, we are over 5x faster doing it this way

# BUT we can do even better
measure {
  100_000.times do
    Date.civil(date[0,4].to_i, date[5, 2].to_i, date[8,2].to_i)
  end
}
# {"gc":"enabled","time":0.06,"gc_count":42,"memory":"0 MB"} no additional memory was created, runtime is about the same


