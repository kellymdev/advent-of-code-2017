class CalculateGroupScore
  attr_accessor :groups, :score

  def initialize(list)
    @groups = list.strip
    @score = 0
  end

  def calculate_score
    score_groups
  end

  def print_score
    puts "The group score is: #{score}"
  end

  private

  def score_groups
    opening_braces = 0
    in_garbage = false
    cancel_char = false

    groups.chars.each do |char|
      if cancel_char
        cancel_char = false
        next
      end

      if group_start?(char) && !in_garbage
        opening_braces += 1
      elsif group_end?(char) && !in_garbage
        @score += opening_braces
        opening_braces -= 1
      elsif garbage_start?(char)
        in_garbage = true
      elsif cancel_character?(char)
        cancel_char = true
      elsif garbage_end?(char)
        in_garbage = false
      end
    end
  end

  def group_start?(char)
    char == '{'
  end

  def group_end?(char)
    char == '}'
  end

  def garbage_start?(char)
    char == '<'
  end

  def garbage_end?(char)
    char == '>'
  end

  def cancel_character?(char)
    char == '!'
  end
end
