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
    corners = find_corners(values, bottom_corner)

    if (corners[:bottom_corner_value] + values - 1) > cell
      find_first_side(values, bottom_corner, corners[:top_right_corner_value])
    elsif (corners[:bottom_corner_value] + values * 2 - 1) > cell
      find_second_side(values, bottom_corner, corners[:top_right_corner_value])
    elsif (corners[:bottom_corner_value] + values * 3 - 2) > cell
      find_third_side(values, bottom_corner, corners[:top_left_corner_value])
    else
      find_fourth_side(values, bottom_corner, corners[:bottom_left_corner_value])
    end
  end

  def find_first_side(values, bottom_corner, top_right_corner)
    mid_row = top_right_corner - (values - 1) / 2
    row = if cell > mid_row
            cell - mid_row
          else
            mid_row - cell
          end

    { row: row, column: bottom_corner + 1 }
  end

  def find_second_side(values, bottom_corner, top_right_corner)
    mid_column = top_right_corner + values / 2
    column = if cell > mid_column
               -(cell - mid_column)
             else
               mid_column - cell
             end

    { row: bottom_corner + 1, column: column }
  end

  def find_third_side(values, bottom_corner, top_left_corner)
    mid_row = top_left_corner + values / 2
    row = if cell > mid_row
            mid_row - cell
          else
            cell - mid_row
          end

    { row: row, column: -bottom_corner + 1 }
  end

  def find_fourth_side(values, bottom_corner, bottom_left_corner)
    mid_column = bottom_left_corner + values / 2
    column = if cell > mid_column
               cell - mid_column
             else
               -(mid_column - cell)
             end

    { row: -bottom_corner - 1, column: column }
  end

  def find_corners(side_values, bottom_corner)
    bottom_corner_square = bottom_corner * 2 + 1
    bottom_corner_value = bottom_corner_square * bottom_corner_square
    top_right_corner_value = bottom_corner_value + side_values - 1
    top_left_corner_value = top_right_corner_value + side_values - 1
    bottom_left_corner_value = top_left_corner_value + side_values - 1

    {
      bottom_corner_value: bottom_corner_value,
      top_right_corner_value: top_right_corner_value,
      top_left_corner_value: top_left_corner_value,
      bottom_left_corner_value: bottom_left_corner_value
    }
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
