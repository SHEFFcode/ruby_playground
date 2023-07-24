require_relative './perf_benchmark_tool'

strA = 'X' * 1024 * 1024 * 10 # 10MB string
strB = 'X' * 1024 * 1024 * 10 # 10MB string
measure do 
  p strA[0]
  strA = strA.downcase
  p strA[0]
end
# {"gc":"enabled","time":0.01,"gc_count":1,"memory":"10 MB"}

measure do
  p strB[0]
  strB.downcase!
  p strB[0]
end
# {"gc":"enabled","time":0.01,"gc_count":1,"memory":"0 MB"}