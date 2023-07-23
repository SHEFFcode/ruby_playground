GC.disable

before = ObjectSpace.count_objects

Array.new(10_000).each do |i|
  [0, 1].each do |j|
    # do something
  end
end

after = ObjectSpace.count_objects

p "# of arrays #{after[:T_ARRAY] - before[:T_ARRAY]}"
# "# of arrays 10001"
p "# of nodes #{after[:T_NODE] - before[:T_NODE]}"
# # of nodes 0


before = ObjectSpace.count_objects

Array.new(10_000).each do |i|
  [0, 1].each_with_index do |j|
    # do something
  end
end

after = ObjectSpace.count_objects

p "# of arrays #{after[:T_ARRAY] - before[:T_ARRAY]}"
# "# of arrays 10001"
p "# of nodes #{after[:T_NODE] - before[:T_NODE]}"
# # of nodes 20000

# So the number of nodes has increased significantly
# We get an additional *memo node in memory, which doubles the number of nodes that get created for each call

# rb_ary_each implementation: https://github.com/ruby/ruby/blob/bcc160b449f63bc7608feaa125259bdedbe6e115/array.c#L2522
# rb_ary_each_with_index implementation: https://github.com/ruby/ruby/blob/bcc160b449f63bc7608feaa125259bdedbe6e115/enum.c#L2967

# Go back to the presentation to see a listing of which iterators create more than 1 node.