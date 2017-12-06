require_relative 'allocate_memory'

input = '5  1 10  0 1 7 13  14  3 12  8 10  7 12  0 6'

# Part One
memory = AllocateMemory.new(input)
memory.distribute_memory
memory.print_cycles

# Part Two
loops = AllocateMemory.new(input)
loops.loop_twice
loops.print_cycles
