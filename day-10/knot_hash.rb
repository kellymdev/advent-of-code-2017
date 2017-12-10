class KnotHash
  attr_reader :lengths
  attr_accessor :list, :current_position, :skip_size

  LIST_SIZE = 255 # List size is 0 indexed, so 255 becomes a list of 256 numbers

  def initialize(length_list)
    @lengths = format_lengths(length_list)
    @list = create_list
    @current_position = 0
    @skip_size = 0
  end

  def hash_list
    lengths.each do |length|
      hash_sequence(length) if valid_length?(length)
      increment_current_position(length)
      increment_skip_size
    end
  end

  def multiply_first_two_numbers
    result = list[0] * list[1]
    puts "Result: #{result}"
  end

  private

  def valid_length?(length)
    length <= (LIST_SIZE)
  end

  def hash_sequence(length)
    sequence = find_sequence(length)
    sequence.reverse!
    write_sequence(sequence)
  end

  def find_sequence(length)
    (current_position..current_position + length - 1).map do |value|
      if value > LIST_SIZE
        list[value - list.length]
      else
        list[value]
      end
    end
  end

  def write_sequence(sequence)
    (current_position..current_position + sequence.length - 1).map.with_index do |value, index|
      if value > LIST_SIZE
        @list[value - list.length] = sequence[index]
      else
        @list[value] = sequence[index]
      end
    end
  end

  def increment_current_position(length)
    @current_position += (length + skip_size)

    decrement_current_position if current_position > LIST_SIZE
  end

  def decrement_current_position
    @current_position -= list.length
  end

  def increment_skip_size
    @skip_size += 1
  end

  def format_lengths(length_list)
    length_list.split(',').map(&:to_i)
  end

  def create_list
    (0..LIST_SIZE).map.with_index do |_, index|
      index
    end
  end
end
