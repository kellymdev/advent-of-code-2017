class CalculateGroupScore
  attr_accessor :groups, :score, :garbage_count

  def initialize(list)
    @groups = list.strip
    @score = 0
    @garbage_count = 0
  end

  def calculate_score
    score_groups
  end

  def print_score
    puts "The group score is: #{score}"
  end

  def print_garbage_count
    puts "The garbage count is: #{garbage_count}"
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

      increment_garbage_count if in_garbage

      if group_start?(char) && !in_garbage
        opening_braces += 1
      elsif group_end?(char) && !in_garbage
        @score += opening_braces
        opening_braces -= 1
      elsif garbage_start?(char)
        in_garbage = true
      elsif cancel_character?(char)
        cancel_char = true
        decrement_garbage_count if in_garbage
      elsif garbage_end?(char)
        in_garbage = false
        decrement_garbage_count
      end
    end
  end

  def increment_garbage_count
    @garbage_count += 1
  end

  def decrement_garbage_count
    @garbage_count -= 1
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
