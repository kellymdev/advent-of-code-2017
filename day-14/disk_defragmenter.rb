require_relative '../day-10/ascii_knot_hash'

class DiskDefragmenter
  attr_reader :key_string
  attr_accessor :grid

  USED_SQUARE = '#'
  UNUSED_SQUARE = '.'

  def initialize(key_string)
    @key_string = key_string
    @grid = []
  end

  def calculate_disk_usage
    (0..127).each do |row|
      knot_hash = create_knot_hash(row)
      binary = convert_to_binary(knot_hash)
      populate_row(row, binary)
    end

    calculate_used_squares
  end

  def print_disk_usage(usage)
    puts "#{usage} squares used"
  end

  private

  def calculate_used_squares
    usage = 0

    grid.each do |row|
      row.each do |column|
        usage += 1 if used?(column)
      end
    end

    usage
  end

  def convert_to_binary(knot_hash)
    knot_hash.hex.to_s(2).rjust(knot_hash.size * 4, '0')
  end

  def create_knot_hash(row)
    hash_input = "#{key_string}-#{row}"

    AsciiKnotHash.new(hash_input).create_hash
  end

  def populate_row(row, binary)
    new_row = binary.chars.map do |char|
      if char == '1'
        USED_SQUARE
      elsif char == '0'
        UNUSED_SQUARE
      end
    end

    grid << new_row
  end

  def set_grid_for_position(row, column, value)
    @grid[row][column] = value
  end

  def used?(value)
    value == USED_SQUARE
  end
end
