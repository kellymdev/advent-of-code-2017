class Program
  attr_reader :instructions, :program_id
  attr_accessor :registers, :current_instruction, :sent_values, :received_values

  def initialize(program_id, instructions)
    @program_id = program_id
    @instructions = format_instructions(instructions)
    @registers = create_registers(program_id)
    @received_values = []
    @sent_values = []
    @current_instruction = 0
  end

  def run_program
    while current_instruction < instructions.size
      instruction = instructions[current_instruction]
      perform_instruction(instruction)
      @current_instruction += 1 unless jump_performed?(instruction)
      return sent_values.last if send_value?(instruction)
    end
  end

  def receive_new_value(value)
    @received_values << value
  end

  def print_sent_value_count
    puts "#{sent_values.size} values were sent"
  end

  private

  def perform_instruction(instruction)
    action = instruction[0..2]
    register = instruction[4]
    value = instruction[6..-1]

    case action
    when 'snd' then send_value(register)
    when 'set' then set_register_value(register, value)
    when 'add' then add_register_value(register, value)
    when 'mul' then multiply_register_value(register, value)
    when 'mod' then modulo_register_value(register, value)
    when 'rcv' then receive_value(register)
    when 'jgz' then jump(register, value)
    end
  end

  def send_value(register)
    @sent_values << registers[register]
  end

  def set_register_value(register, value)
    @registers[register] = if register?(value)
                             registers[value]
                           else
                             value.to_i
                           end
  end

  def add_register_value(register, value)
    if register?(value)
      @registers[register] += registers[value]
    else
      @registers[register] += value.to_i
    end
  end

  def multiply_register_value(register, value)
    @registers[register] = if register?(value)
                             registers[register] * registers[value]
                           else
                             registers[register] * value.to_i
                           end
  end

  def modulo_register_value(register, value)
    @registers[register] = if register?(value)
                             registers[register] % registers[value]
                           else
                             registers[register] % value.to_i
                           end
  end

  def receive_value(register)
    return false unless received_values.size > 0

    @registers[register] = received_values.shift
  end

  def jump(register, value)
    register_val = register_value(register)

    return if register_val.zero?

    if register?(value)
      @current_instruction += registers[value]
    else
      @current_instruction += value.to_i
    end
  end

  def jump_performed?(instruction)
    value = register_value(instruction[4])

    instruction[0..2] == 'jgz' && !value.zero?
  end

  def register_value(register)
    if register?(register)
      registers[register]
    else
      register.to_i
    end
  end

  def register?(value)
    registers.keys.include?(value)
  end

  def send_value?(instruction)
    instruction[0..2] == 'snd'
  end

  def format_instructions(instructions)
    instructions.split("\n")
  end

  def create_registers(program_id)
    registers = {}

    instructions.each do |instruction|
      register = instruction[4]
      next unless letter?(register)

      if p_register?(registers[register])
        registers[register] = start_value_for_p_register
      else
        registers[register] = 0
      end
    end

    registers
  end

  def p_register?(value)
    value == 'p'
  end

  def letter?(value)
    value.to_i.zero?
  end
end
