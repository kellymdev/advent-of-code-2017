require_relative 'knot_hash'
require_relative 'ascii_knot_hash'

# input = '70,66,255,2,48,0,54,48,80,141,244,254,160,108,1,41'
input = '1,2,3'

# Part 1
knot_hash = KnotHash.new(input)
knot_hash.hash_list
knot_hash.multiply_first_two_numbers

# Part 2
ascii_hash = AsciiKnotHash.new(input)
new_hash = ascii_hash.create_hash
ascii_hash.print_hash(new_hash)
