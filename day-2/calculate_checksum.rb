class CalculateChecksum
  attr_reader :spreadsheet
  attr_accessor :checksum

  def initialize(spreadsheet)
    @spreadsheet = spreadsheet
    @checksum = 0
  end

  def calculate_checksum
    formatted_spreadsheet.each do |row|
      formatted_row = format_row(row)
      row_checksum = formatted_row[-1] - formatted_row[0]
      increment_checksum(row_checksum)
    end
  end

  def calculate_divisible_checksum
    formatted_spreadsheet.each do |row|
      formatted_row = format_row(row)
      result = find_divisible_result(formatted_row)
      increment_checksum(result)
    end
  end

  def print_checksum
    puts checksum
  end

  private

  def find_divisible_result(formatted_row)
    formatted_row.reverse_each do |num|
      formatted_row.each do |pair|
        next if num == pair
        next unless divides_evenly?(num, pair)
        return num / pair
      end
    end
  end

  def divides_evenly?(num1, num2)
    num1 % num2 == 0
  end

  def increment_checksum(num)
    @checksum += num
  end

  def format_row(row)
    split_row = row.split(' ')
    integer_row = split_row.map(&:to_i)
    integer_row.sort!
  end

  def formatted_spreadsheet
    spreadsheet.split("\n")
  end
end
