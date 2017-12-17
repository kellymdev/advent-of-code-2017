require_relative 'spinlock'

input = 345

# Part 1
spinlock = Spinlock.new(input)
spinlock.create_circular_buffer
spinlock.print_value_after_2017
