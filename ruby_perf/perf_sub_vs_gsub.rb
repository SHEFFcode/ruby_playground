require_relative 'perf_benchmark_tool'

str = 'http://www.avant.com'

measure {
  100_000.times do 
    str.sub('http', 'https')
  end
}
# {"gc":"enabled","time":0.03,"gc_count":43,"memory":"0 MB"}

p str

measure {
  100_000.times do 
    str.gsub('http', 'https') # don't gsub everything
  end
}

# {"gc":"enabled","time":0.05,"gc_count":53,"memory":"0 MB"}

# ============= Try using TR instead of GSub ===================
item = 'slug from title'

measure {
  100_000.times do 
    item.gsub(' ', '_')
  end
}
# {"gc":"enabled","time":0.06,"gc_count":53,"memory":"0 MB"}

p item

measure {
  100_000.times do 
    item.tr(' ', '_')
  end
}

# {"gc":"enabled","time":0.02,"gc_count":32,"memory":"0 MB"}