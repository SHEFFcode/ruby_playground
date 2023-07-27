require_relative 'perf_benchmark_tool'

items = (0...10_000).map(&:to_s).each_with_object({}) do |item, hash|
  hash[item] = item
end

# =========== Key does not exist ================

measure {
  100_000.times do 
    items.fetch(:bar, (0..9).to_a)
  end
}
# {"gc":"enabled","time":0.04,"gc_count":10,"memory":"2 MB"}

measure {
  100_000.times do
    items.fetch(:bar) {(0..9).to_a}
  end
}

# {"gc":"enabled","time":0.04,"gc_count":10,"memory":"0 MB"}


#================ Key exists =====================

measure {
  100_000.times do 
    items.fetch('1', (0..9).to_a)
  end
}
# {"gc":"enabled","time":0.05,"gc_count":15,"memory":"-1 MB"}

measure {
  100_000.times do
    items.fetch('1') {(0..9).to_a}
  end
}

# {"gc":"enabled","time":0.01,"gc_count":5,"memory":"0 MB"}