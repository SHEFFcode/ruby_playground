require 'csv'
require_relative './perf_benchmark_tool'

measure do 
  data = CSV.open('perf_data.csv')
  output = data.readlines.map do |line|
    line.map {|col| col.downcase.gsub(/\b('?[a-z])/) {$1.capitalize}}
  end
  File.open('output.csv', 'w+') {|f| f.write(output.join('\n'))}
end

