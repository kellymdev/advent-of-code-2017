class Firewall
  attr_reader :scanners

  def initialize(scanner_list)
    @scanners = format_scanner_list(scanner_list)
  end

  def calculate_severity_of_trip
    severity = 0

    (0..firewall_size).each do |layer|
      next unless scanner?(layer)

      if scanner_in_top_row?(layer)
        severity += calculate_severity_of_scan(layer)
      end
    end

    severity
  end

  def find_safe_path
    scan_sequences = find_scan_sequences
    (0..firewall_size).each do |second|
      scan_sequences_for_second = scan_sequences.transpose[second]

      next unless safe_path?(scan_sequences_for_second)

      return second
    end
  end

  def print_severity(severity)
    puts "Severity of #{severity}"
  end

  def print_delay(delay)
    puts "Delay the trip by #{delay} picoseconds"
  end

  private

  def safe_path?(scan_sequences_for_second)
    !scan_sequences_for_second.include?(0)
  end

  def find_scan_sequences
    scanners.map do |_, depth|
      length = firewall_size * 3

      sequence = scanner_sequence(depth)
      sequence += sequence until sequence.size > length
      sequence[0..length]
    end
  end

  def calculate_severity_of_scan(layer)
    scanner_depth = scanners[layer]
    layer * scanner_depth
  end

  def scanner_in_top_row?(layer)
    calculate_position_of_scanner(layer) == 0
  end

  def calculate_position_of_scanner(layer)
    scanner_depth = scanners[layer]
    sequence = scanner_sequence(scanner_depth)
    sequence += sequence until sequence.size >= layer + 1

    sequence[layer]
  end

  def scanner_sequence(scanner_depth)
    sequence = (0..(scanner_depth - 1)).to_a

    # reverse the sequence and pop both ends off to get the return sequence
    reversed = sequence.reverse
    reversed.pop
    reversed.shift

    sequence + reversed
  end

  def scanner?(layer)
    scanners.key?(layer)
  end

  def firewall_size
    scanners.keys.last
  end

  def format_scanner_list(scanner_list)
    security_scanners = scanner_list.split("\n")
    formatted_scanners = {}

    security_scanners.each do |scanner|
      depth, range = scanner.split(': ')
      formatted_scanners[depth.to_i] = range.to_i
    end

    formatted_scanners
  end
end
