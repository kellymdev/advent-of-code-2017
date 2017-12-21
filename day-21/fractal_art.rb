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
                # divide image by 3x3
              end

    # match enhanement rule
    # enlarge image
  end

  def divide_image_into_2x2
    number_of_squares = image_size * image_size / 4
    current_row = 0
    current_column = 0

    find_2x2_image(current_row, current_column)
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
