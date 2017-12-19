class RoutingDiagram
  attr_reader :diagram
  attr_accessor :current_row, :current_column, :current_direction, :letters, :steps

  VERTICAL_LINE = '|'
  HORIZONTAL_LINE = '-'
  CONNECTOR = '+'
  EMPTY_SQUARE = ' '
  LETTERS = ('A'..'Z').to_a

  DOWN = 'down'
  UP = 'up'
  LEFT = 'left'
  RIGHT = 'right'

  def initialize(diagram)
    @diagram = format_diagram(diagram)
    @current_row = 0
    @current_column = set_initial_column
    @current_direction = DOWN
    @letters = []
    @steps = 0
  end

  def follow_route
    current_square = diagram[current_row][current_column]

    while current_square != EMPTY_SQUARE
      determine_next_move(current_square)
      increment_steps

      current_square = diagram[current_row][current_column]
    end
  end

  def print_letter_path
    puts "Letters: #{letters.join}"
  end

  def print_step_count
    puts "Steps: #{steps}"
  end

  private

  def determine_next_move(current_square)
    case current_square
    when CONNECTOR
      set_new_direction
      move_in_current_direction
    when VERTICAL_LINE, HORIZONTAL_LINE
      move_in_current_direction
    else # it's a letter square
      record_letter(current_square)
    end
  end

  def set_new_direction
    case current_direction
    when LEFT, RIGHT
      determine_vertical_direction
    when UP, DOWN
      determine_horizontal_direction
    end
  end

  def determine_horizontal_direction
    @current_direction = if left_cell_is_a_line_or_letter
                           LEFT
                         else
                           RIGHT
                         end
  end

  def left_cell_is_a_line_or_letter
    (current_column - 1) > -1 && diagram[current_row][current_column - 1] == HORIZONTAL_LINE || LETTERS.include?(diagram[current_row][current_column - 1])
  end

  def determine_vertical_direction
    @current_direction = if top_cell_is_a_line_or_letter
                           UP
                         else
                           DOWN
                         end
  end

  def top_cell_is_a_line_or_letter
    (current_row - 1) > -1 && diagram[current_row - 1][current_column] == VERTICAL_LINE || LETTERS.include?(diagram[current_row - 1][current_column])
  end

  def move_in_current_direction
    case current_direction
    when LEFT, RIGHT
      move_horizontally
    when UP, DOWN
      move_vertically
    end
  end

  def record_letter(letter)
    @letters << letter

    move_in_current_direction
  end

  def move_horizontally
    if current_direction == LEFT
      decrement_column
    elsif current_direction == RIGHT
      increment_column
    end
  end

  def move_vertically
    if current_direction == DOWN
      increment_row
    elsif current_direction == UP
      decrement_row
    end
  end

  def increment_steps
    @steps += 1
  end

  def increment_column
    @current_column += 1
  end

  def decrement_column
    @current_column -= 1
  end

  def increment_row
    @current_row += 1
  end

  def decrement_row
    @current_row -= 1
  end

  def set_initial_column
    @current_column = diagram.first.index(VERTICAL_LINE)
  end

  def format_diagram(diagram)
    rows = diagram.split("\n")
    rows.map(&:chars)
  end
end
