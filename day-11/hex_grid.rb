class HexGrid
  attr_reader :directions
  attr_accessor :current_position

  START_POSITION = { row: 0, column: 0 }

  def initialize(directions)
    @directions = format_directions(directions)
    @current_position = { row: START_POSITION[:row], column: START_POSITION[:column] }
  end

  def count_steps
    directions.each do |direction|
      follow_direction(direction)
    end

    steps = calculate_steps
    print_steps(steps)
  end

  private

  def print_steps(steps)
    puts "#{steps} steps"
  end

  def calculate_steps
    if current_position[:row].abs == current_position[:column].abs
      current_position[:row].abs
    elsif current_position[:row].zero?
      current_position[:column].abs
    elsif current_position[:column].zero?
      current_position[:row].abs
    else
      (current_position[:row] / 2 - START_POSITION[:row]).abs + (current_position[:column] - START_POSITION[:column]).abs
    end
  end

  def follow_direction(direction)
    case direction
    when 'n'
      increment_row
    when 'ne'
      increment_row
      increment_column
    when 'nw'
      increment_row
      decrement_column
    when 's'
      decrement_row
    when 'se'
      decrement_row
      increment_column
    when 'sw'
      decrement_row
      decrement_column
    end
  end

  def increment_column
    @current_position[:column] += 1
  end

  def decrement_column
    @current_position[:column] -= 1
  end

  def increment_row
    @current_position[:row] += 1
  end

  def decrement_row
    @current_position[:row] -= 1
  end

  def format_directions(directions)
    directions.split(',')
  end
end
