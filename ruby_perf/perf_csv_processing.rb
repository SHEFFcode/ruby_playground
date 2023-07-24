require_relative './perf_benchmark_tool'

# num_rows = 100_000
# num_cols = 10
# data = Array.new(num_rows) {
#   Array.new(num_cols) {'x' * 1000} # 1000 byte string * 10 cols * 100_000 rows ~953MB of data
# }

# measure {
#   time = Benchmark.realtime do
#     csv = data.map do |row|
#       row.join(',') # these will all be intermediate results
#     end.join('\n')
#   end
# }

# Here we use regular map function, join on intermediate results, and then join on final results
# 953MB takes up almost twice as much when u use the approach above.
# {"gc":"enabled","time":2.01,"gc_count":32,"memory":"1718 MB"}



# # Performance optimized

num_rows = 100_000
num_cols = 10
data = Array.new(num_rows) {
  Array.new(num_cols) {'x' * 1000}
}

measure do
  csv = ''
  num_rows.times do |i|
    num_cols.times do |j|
      csv << data[i][j]
      csv << ',' unless j == num_cols - 1
    end
    csv << "\n" unless i == num_rows - 1
  end
end

# This is done in less than half the time and with thalf the memory
# When a string gets too big to fit in an object it goes to the
# memory of the OS rather than ruby
# {"gc":"enabled","time":0.91,"gc_count":3,"memory":"434 MB"}