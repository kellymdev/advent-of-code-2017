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

  def print_checksum
    puts checksum
  end

  private

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
