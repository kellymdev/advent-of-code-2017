class Memory
  attr_reader :cell
  attr_accessor :steps

  PORT_CELL_LOCATION = { number: 1, row: 0, column: 0 }.freeze

  def initialize(cell)
    @cell = cell.to_i
    @steps = 0
  end

  def calculate_steps
    return 0 if port_location?(cell)
    bottom_corner = find_bottom_corner_coordinate
    coordinates = find_cell_coordinates(bottom_corner)

    count_steps(coordinates)
  end

  def print_steps
    puts steps
  end

  private

  def port_location?(num)
    num == PORT_CELL_LOCATION[:number]
  end

  def closest_odd_square_root(num)
    value = square_root(num).to_i
    value.odd? ? value : value - 1
  end

  def square_root(num)
    Math.sqrt(num)
  end

  def find_bottom_corner_coordinate
    corner_square = closest_odd_square_root(cell)
    (corner_square - 1) / 2
  end

  def number_of_values_in_row(coordinate)
    8 * (coordinate.abs + 1)
  end

  def find_cell_coordinates(bottom_corner)
    values = values_per_side(bottom_corner)
    bottom_corner_square = bottom_corner * 2 + 1
    bottom_corner_value = bottom_corner_square * bottom_corner_square

    if (bottom_corner_value + values - 1) > cell # cell is in the first side
      { row: -bottom_corner + cell - bottom_corner_value - 1, column: bottom_corner + 1 }
    elsif (bottom_corner_value + values * 2 - 1) > cell # cell is in the second side
      { row: -bottom_corner + values - 1, column: cell - bottom_corner_value + values - 1 }
    end
  end

  def values_per_side(num)
    (number_of_values_in_row(num) / 4) + 1
  end

  def count_steps(coordinates)
    row_difference = (coordinates[:row] - PORT_CELL_LOCATION[:row]).abs
    column_difference = (coordinates[:column] - PORT_CELL_LOCATION[:column]).abs
    @steps = row_difference + column_difference
  end
end
