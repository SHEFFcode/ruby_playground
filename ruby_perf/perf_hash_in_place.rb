require_relative('perf_benchmark_tool')

items = (1..100_000).map(&:to_s)

measure {
  res = items.inject({}) do |hash, item|
    hash.merge(item => item)
  end
}
# {"gc":"enabled","time":16.86,"gc_count":6638,"memory":"667 MB"}

measure {
  res = items.inject({}) do |hash, item|
    hash.merge!(item => item)
  end
}

# {"gc":"enabled","time":0.04,"gc_count":2,"memory":"9 MB"}

measure {
  res = items.each_with_object({}) do |item, hash|
    hash[item] = item
  end
}

# {"gc":"enabled","time":0.03,"gc_count":1,"memory":"0 MB"}