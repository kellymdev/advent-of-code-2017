require_relative 'spinlock'

input = 345

# Part 1
spinlock = Spinlock.new(input)
spinlock.create_circular_buffer
spinlock.print_value_after(2017)

# Part 2
angry_spinlock = Spinlock.new(input)
angry_spinlock.create_fast_circular_buffer
angry_spinlock.print_value_after(0)
