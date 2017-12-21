class FractalArt
  attr_reader :rules
  attr_accessor :image

  ON = '#'
  OFF = '.'
  ITERATIONS = 2

  def initialize(rule_list)
    @rules = format_rules(rule_list)
    @image = [[OFF, ON, OFF],
              [OFF, OFF, ON],
              [ON, ON, ON]]
  end

  def generate_art
    ITERATIONS.times do
      enhance_image
    end
  end

  private

  def enhance_image
    squares = if (image_size % 2).zero?
                divide_image_into_2x2
              else
                divide_image_into_3x3
              end

    enhancements = squares.flat_map do |square|
      patterns = find_possible_patterns_from(square)
      patterns.select { |pattern| find_pattern_match(pattern) }
    end

    enlarge_image(enhancements)
  end

  def enlarge_image(enhancements)
    square_size = enhancements.first.split('/').first.size
    number_of_squares = enhancements.size
    squares_per_side = Math.sqrt(number_of_squares).to_i
    coordinates = determine_coordinates_for(square_size, graphic_size: squares_per_side * square_size)

    enhancements.each.with_index do |enhancement, index|
      update_image_with(enhancement, coordinates[index])
    end
  end

  def update_image_with(enhancement, coordinate_pair)
    rows = enhancement.split('/')
    current_row = coordinate_pair[0]
    current_column = coordinate_pair[1]

    rows.each.with_index do |row, index|
      cells = row.chars

      cells.each do |cell|
        @image[current_row][current_column + index] = cell
      end

      current_row += 1
    end
  end

  def divide_image_into_2x2
    coordinates = determine_coordinates_for(2)

    coordinates.map do |coordinate_pair|
      find_2x2_image(coordinate_pair[0], coordinate_pair[1])
    end
  end

  def divide_image_into_3x3
    coordinates = determine_coordinates_for(3)

    coordinates.map do |coordinate_pair|
      find_3x3_image(coordinate_pair[0], coordinate_pair[1])
    end
  end

  def determine_coordinates_for(square_size, graphic_size: image_size)
    squares_per_side = graphic_size / square_size
    number_of_squares = squares_per_side * squares_per_side
    coordinates = []
    current_row = 0
    current_column = 0

    while coordinates.size < number_of_squares
      coordinates << [current_row, current_column]
      current_column += square_size

      if (coordinates.size % squares_per_side).zero?
        current_row += square_size
        current_column = 0
      end
    end

    coordinates
  end

  def find_2x2_image(row, column)
    "#{image[row][column]}#{image[row][column + 1]}/#{image[row + 1][column]}#{image[row + 1][column + 1]}"
  end

  def find_3x3_image(row, column)
    "#{image[row][column]}#{image[row][column + 1]}#{image[row][column + 2]}/#{image[row + 1][column]}#{image[row + 1][column + 1]}#{image[row + 1][column + 2]}/#{image[row + 2][column]}#{image[row + 2][column + 1]}#{image[row + 2][column + 2]}"
  end

  def find_pattern_match(pattern)
    patterns = find_possible_patterns_from(pattern)
    patterns.map do |rule|
      rules[rule]
    end.compact.first
  end

  def find_possible_patterns_from(pattern)
    [pattern,
     pattern.reverse,
     inverted = pattern.split('/').map(&:reverse).join('/'),
     inverted.reverse].uniq
  end

  def image_size
    image.first.size
  end

  def format_rules(rule_list)
    formatted_rules = {}
    rules = rule_list.split("\n")
    rules.each do |rule|
      pattern, enhancement = rule.split(' => ')
      formatted_rules[pattern] = enhancement
    end

    formatted_rules
  end
end
