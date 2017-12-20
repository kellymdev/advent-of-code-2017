require_relative '../day-10/ascii_knot_hash'

class DiskDefragmenter
  attr_reader :key_string
  attr_accessor :grid, :region_seed

  USED_SQUARE = '#'
  UNUSED_SQUARE = '.'

  def initialize(key_string)
    @key_string = key_string
    @grid = []
    @region_seed = 1
  end

  def calculate_disk_usage
    (0..127).each do |row|
      knot_hash = create_knot_hash(row)
      binary = convert_to_binary(knot_hash)
      populate_row(row, binary)
    end

    calculate_used_squares
  end

  def find_regions
    until regions_completed?
      print_region_seed
      square = find_first_used_square
      set_grid_for_position(square[:row], square[:column], region_seed)
      find_adjacent_squares(square[:row], square[:column])
      @region_seed += 1
    end

    print_grid

    region_seed - 1
  end

  def print_disk_usage(usage)
    puts "#{usage} squares used"
  end

  def print_region_count(region_count)
    puts "#{region_count} regions"
  end

  private

  def print_grid
    grid.each do |row|
      formatted_row = row.map do |column|
        if column.is_a?(Fixnum)
          column.to_s.rjust(4, '0')
        else
          column.rjust(4, '.')
        end
      end

      puts formatted_row.join(',')
    end
  end

  def print_region_seed
    puts "Finding squares for region: #{region_seed}"
  end

  def regions_completed?
    grid.none? { |row| row.include?(USED_SQUARE) }
  end

  def find_first_used_square
    grid.each.with_index do |row, row_index|
      row.each.with_index do |column, column_index|
        next unless used?(column)

        return { row: row_index, column: column_index }
      end
    end
  end

  def find_adjacent_squares(row_index, column_index)
    prior_row = row_index - 1
    prior_column = column_index - 1
    next_row = row_index + 1
    next_column = column_index + 1

    if next_column < grid.size
      process_square(row_index, next_column)
    end

    if next_row < grid.size
      process_square(next_row, column_index)
    end

    if prior_row > -1
      process_square(prior_row, column_index)
    end

    if prior_column > -1
      process_square(row_index, prior_column)
    end
  end

  def process_square(row, column)
    if used?(grid[row][column])
      set_grid_for_position(row, column, region_seed)
      find_adjacent_squares(row, column)
    end
  end

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
