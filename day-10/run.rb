require_relative 'knot_hash'

input = '70,66,255,2,48,0,54,48,80,141,244,254,160,108,1,41'

# Part 1
knot_hash = KnotHash.new(input)
knot_hash.hash_list
knot_hash.multiply_first_two_numbers
