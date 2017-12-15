require_relative 'compare_generators'

generator_a = 873
generator_b = 583

# Part 1
generators = CompareGenerators.new(generator_a, generator_b)
pairs = generators.find_pairs
generators.print_pair_count(pairs)
