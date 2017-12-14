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
    usage = 0

    (0..127).each do |row|
      knot_hash = create_knot_hash(row)
    end

    usage
  end

  def print_disk_usage(usage)
    puts "#{usage} squares used"
  end

  private

  def create_knot_hash(row)
    hash_input = "#{key_string}-#{row}"

    AsciiKnotHash.new(hash_input).create_hash
  end

  def set_grid_for_position(row, column, value)
    grid[row][column] = value
  end

  def used?(row, column)
    grid[row][column] == USED_SQUARE
  end

  def unused?(row, column)
    grid[row][column] == UNUSED_SQUARE
  end
end
