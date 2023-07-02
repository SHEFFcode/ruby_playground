require 'set'
new_england = %w{CT MN MS NH RI VT}

state_set = Set.new(new_england)
p state_set # #<Set: {"CT", "MN", "MS", "NH", "RI", "VT"}>
# There is no literal constructor becase sets are part of the standard library, rather than language core
# so the core is loaded up before the library gets loaded, standard library is built with the language core elements

names = %w{david chad amy}
names_set = Set.new(names) {|n| n.upcase}
p names_set # made everyone capitalized

# Manipulating set elements
tri_state = Set.new(%w{NJ NY})
p tri_state # #<Set: {"NJ", "NY"}>
tri_state << 'CT' # this can also be done as tri_state.add('CT')
p tri_state # #<Set: {"NJ", "NY", "CT"}>
tri_state << 'IL'
tri_state.delete('IL')
p tri_state # #<Set: {"NJ", "NY", "CT"}>

# Deleting a non existing element from the set does nothing
p tri_state.delete('hello') # #<Set: {"NJ", "NY", "CT"}>

# Set intersection, union and difference
# Intersection is aliased as &
# union is aliased as +
# diference is aliased as -
# Each returns a new set

p tri_state # #<Set: {"NJ", "NY", "CT"}>
p state_set # #<Set: {"CT", "MN", "MS", "NH", "RI", "VT"}>

p state_set - tri_state # #<Set: {"MN", "MS", "NH", "RI", "VT"}> elements of the first set less the ones that appear in the second one
p state_set + tri_state # #<Set: {"CT", "MN", "MS", "NH", "RI", "VT", "NJ", "NY"}> adds 2 more elements
p state_set & tri_state # #<Set: {"CT"}> just the common element of CT
p state_set ^ tri_state # {"NJ", "NY", "MN", "MS", "NH", "RI", "VT"}> All the sets together aside from the one common element

# Subset and superset
small_states = Set.new(%w{CT DE RI})
tiny_states = Set.new(%w{DE RI})

p tiny_states.subset?(small_states) # are all the tiny states part of the small states collection?, true
p small_states.superset?(tiny_states) # does the small states collection include all the tiny states, true

# There is also a concept of proper_subset and proper_superset, which means one is bigger then the other
p tiny_states.proper_subset?(small_states) # are all the tiny states part of the small states collection?, true
p small_states.proper_superset?(tiny_states) # does the small states collection include all the tiny states, true