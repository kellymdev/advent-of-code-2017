class CompareGenerators
  attr_accessor :generator_a, :generator_b

  GENERATOR_A_FACTOR = 16_807
  GENERATOR_B_FACTOR = 48_271
  DIVISOR = 2_147_483_647

  def initialize(generator_a, generator_b)
    @generator_a = generator_a
    @generator_b = generator_b
  end

  def find_pairs
    pairs = 0

    40_000_000.times do
      print_generator_values
      generate_next_values
      values = convert_values_to_binary
      pairs += 1 if pair?(values)
    end

    pairs
  end

  def print_pair_count(pair_count)
    puts "#{pair_count} pairs"
  end

  private

  def print_generator_values
    puts "a: #{generator_a}, b: #{generator_b}"
  end

  def pair?(values_hash)
    a = values_hash[:a][16..-1]
    b = values_hash[:b][16..-1]

    a == b
  end

  def convert_values_to_binary
    a = convert_to_binary(generator_a)
    b = convert_to_binary(generator_b)

    { a: a, b: b }
  end

  def convert_to_binary(generator_value)
    value = generator_value.to_s(2)

    value = '0' + value while value.size < 32

    value
  end

  def generate_next_values
    @generator_a = generate_next_value(generator_a, GENERATOR_A_FACTOR)
    @generator_b = generate_next_value(generator_b, GENERATOR_B_FACTOR)
  end

  def generate_next_value(generator_previous_value, generation_factor)
    generator_previous_value * generation_factor % DIVISOR
  end
end
