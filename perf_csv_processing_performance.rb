require 'benchmark'

GC.disable # try without garbage collection

num_rows = 100_000
num_cols = 10
data = Array.new(num_rows) {
  Array.new(num_cols) {'x' * 1000}
}

time = Benchmark.realtime do
  csv = data.map do |row|
    row.join(',') # these will all be intermediate results
  end.join('\n')
end

puts time.round(2) 
# GC ON 1.85,  0.95,  1.03,  1.06
# GC OF 0.71,  0.70,  0.70,  0.68