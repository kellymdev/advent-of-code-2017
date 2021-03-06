class SumDigits
  attr_reader :captcha
  attr_accessor :total

  def initialize(captcha)
    @captcha = captcha
    @total = 0
  end

  def sum_digits
    captcha.chars.each.with_index do |char, index|
      if last_digit_matches?(index, char) || matching_digits?(char, captcha.chars[index + 1])
        increment_total(char)
      end
    end
  end

  def circular_sum_digits
    captcha.chars.each.with_index do |char, index|
      increment_total(char) if matching_digits?(char, char_to_compare(index))
    end
  end

  def print_total
    puts "Sum total: #{total}"
  end

  private

  def char_to_compare(index)
    captcha.chars[(index + number_of_steps_forward) % captcha_length]
  end

  def number_of_steps_forward
    captcha_length / 2
  end

  def last_digit_matches?(index, char)
    last_digit?(index) && matching_digits?(char, captcha.chars[0])
  end

  def last_digit?(index_value)
    index_value + 1 == captcha_length
  end

  def captcha_length
    captcha.length
  end

  def matching_digits?(digit1, digit2)
    digit1 == digit2
  end

  def increment_total(digit)
    @total += digit.to_i
  end
end
