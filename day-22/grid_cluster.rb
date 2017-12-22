class GridCluster
  attr_reader :grid_layout
  attr_accessor :grid, :current_row, :current_column, :direction, :infection_count

  INFECTED_NODE = '#'
  CLEAN_NODE = '.'

  def initialize(grid_layout)
    @grid_layout = grid_layout
    @grid = Hash.new { |hash, key| hash[key] = {} }
    @direction = 'up'
    @infection_count = 0
  end

  def propagate_virus
    format_grid

    10_000.times do
      perform_burst
    end

    print_infection_count
  end

  private

  def print_infection_count
    puts "There are #{infection_count} new infections"
  end

  def perform_burst
    if infected?(current_row, current_column)
      turn_right
      clean_current_node
    else
      turn_left
      infect_current_node
    end

    move_forward
  end

  def move_forward
    case direction
    when 'up' then @current_row -= 1
    when 'right' then @current_column += 1
    when 'down' then @current_row += 1
    when 'left' then @current_column -= 1
    end
  end

  def clean_current_node
    @grid[current_row][current_column] = CLEAN_NODE
  end

  def infect_current_node
    @grid[current_row][current_column] = INFECTED_NODE
    @infection_count += 1
  end

  def turn_right
    @direction = case direction
                 when 'up' then 'right'
                 when 'right' then 'down'
                 when 'down' then 'left'
                 when 'left' then 'up'
                 end
  end

  def turn_left
    @direction = case direction
                 when 'up' then 'left'
                 when 'right' then 'up'
                 when 'down' then 'right'
                 when 'left' then 'down'
                 end
  end

  def infected?(row, column)
    grid[row][column] == INFECTED_NODE
  end

  def format_grid
    rows = grid_layout.split("\n")
    current_row_and_column(rows)

    rows.each.with_index do |row, row_index|
      row.chars.each.with_index do |column, column_index|
        @grid[row_index][column_index] = column
      end
    end
  end

  def current_row_and_column(rows)
    @current_row = rows.size % 2
    @current_column = rows.first.size % 2
  end
end
