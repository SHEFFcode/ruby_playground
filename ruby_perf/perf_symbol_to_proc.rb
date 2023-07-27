# ============== Block vs Symbol#to_proc =================
measure {
  (1..1_000_000).map {|i| i.to_s}
}
# {"gc":"enabled","time":0.13,"gc_count":11,"memory":"44 MB"}

measure {
  (1..1_000_000).map(&:to_s)
}

# {"gc":"enabled","time":0.11,"gc_count":2,"memory":"17 MB"}