class Dance
  attr_reader :moves
  attr_accessor :program_order

  def initialize(moves)
    @moves = format_moves(moves)
    @program_order = create_program_array
  end

  def dance
    moves.each do |move|
      perform_move(move)
    end
  end

  def perform_whole_dance
    sequences = find_repeating_sequence
    index = find_sequence_index(sequences)
    @program_order = sequences[index].chars
  end

  def print_program_order
    puts "#{program_order.join}"
  end

  private

  def find_sequence_index(sequences)
    1_000_000_000 % sequences.size
  end

  def find_repeating_sequence
    sequences = []

    until sequences.include?(program_order.join)
      sequences << program_order.join
      dance
    end

    sequences
  end

  def perform_move(move)
    move_type = move[0]
    instruction = move[1..-1]

    case move_type
    when 's' then perform_spin(instruction)
    when 'x' then perform_exchange(instruction)
    when 'p' then perform_partner(instruction)
    end
  end

  def perform_spin(instruction)
    instruction.to_i.times do
      program = program_order.pop
      program_order.unshift(program)
    end
  end

  def perform_exchange(instruction)
    position_a, position_b = instruction.split('/').map(&:to_i)
    program_a = program_order[position_a]
    program_b = program_order[position_b]

    move_positions(position_a, position_b, program_a, program_b)
  end

  def perform_partner(instruction)
    program_a, program_b = instruction.split('/')
    position_a = program_order.index(program_a)
    position_b = program_order.index(program_b)

    move_positions(position_a, position_b, program_a, program_b)
  end

  def move_positions(position_a, position_b, program_a, program_b)
    @program_order[position_a] = program_b
    @program_order[position_b] = program_a
  end

  def format_moves(moves)
    moves.split(',')
  end

  def create_program_array
    ('a'..'p').map { |program| program }
  end
end
