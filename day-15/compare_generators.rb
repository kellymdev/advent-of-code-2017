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

  def find_pairs_of_multiples
    a_values = []
    b_values = []

    5_000_000.times do
      print_generator_values
      a_values << generate_valid_a_value
      b_values << generate_valid_b_value
    end

    compare_a_and_b_values(a_values, b_values)
  end

  def print_pair_count(pair_count)
    puts "#{pair_count} pairs"
  end

  private

  def print_generator_values
    puts "a: #{generator_a}, b: #{generator_b}"
  end

  def compare_a_and_b_values(a_values, b_values)
    pairs = 0

    a_values.each.with_index do |value, index|
      values_hash = { a: value, b: b_values[index] }

      pairs += 1 if pair?(values_hash)
    end

    pairs
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

  def generate_valid_a_value
    @generator_a = generate_next_value(generator_a, GENERATOR_A_FACTOR)

    until divisible_by_4?(generator_a)
      @generator_a = generate_next_value(generator_a, GENERATOR_A_FACTOR)
    end

    convert_to_binary(generator_a)
  end

  def generate_valid_b_value
    @generator_b = generate_next_value(generator_b, GENERATOR_B_FACTOR)

    until divisible_by_8?(generator_b)
      @generator_b = generate_next_value(generator_b, GENERATOR_B_FACTOR)
    end

    convert_to_binary(generator_b)
  end

  def divisible_by_4?(value)
    (value % 4).zero?
  end

  def divisible_by_8?(value)
    (value % 8).zero?
  end

  def generate_next_values
    @generator_a = generate_next_value(generator_a, GENERATOR_A_FACTOR)
    @generator_b = generate_next_value(generator_b, GENERATOR_B_FACTOR)
  end

  def generate_next_value(generator_previous_value, generation_factor)
    generator_previous_value * generation_factor % DIVISOR
  end
end
