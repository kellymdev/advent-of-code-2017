class Duet
  attr_reader :instructions
  attr_accessor :last_frequency, :registers, :current_instruction

  def initialize(instructions)
    @instructions = format_instructions(instructions)
    @registers = create_registers
    @current_instruction = 0
    @last_frequency = 0
  end

  def perform_duet
    while current_instruction < instructions.size
      instruction = instructions[current_instruction]
      perform_instruction(instruction)
      @current_instruction += 1 unless jump_performed?(instruction)
      return if sound_recovered?(instruction)
    end
  end

  def print_frequency
    puts "The frequency is: #{last_frequency}"
  end

  private

  def perform_instruction(instruction)
    action = instruction[0..2]
    register = instruction[4]
    value = instruction[6..-1]

    case action
    when 'snd' then play_sound(register)
    when 'set' then set_register_value(register, value)
    when 'add' then add_register_value(register, value)
    when 'mul' then multiply_register_value(register, value)
    when 'mod' then modulo_register_value(register, value)
    when 'rcv' then recover_sound(register)
    when 'jgz' then jump(register, value)
    end
  end

  def play_sound(register)
    @last_frequency = registers[register]
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

  def recover_sound(register)
    return if registers[register].zero?

    print_frequency
  end

  def jump(register, value)
    register_value = if register?(register)
                       registers[register]
                     else
                       register.to_i
                     end

    return if register_value.zero?

    if register?(value)
      @current_instruction += registers[value]
    else
      @current_instruction += value.to_i
    end
  end

  def jump_performed?(instruction)
    instruction[0..2] == 'jgz' && !registers[instruction[4]].zero?
  end

  def sound_recovered?(instruction)
    instruction[0..2] == 'rcv' && !registers[instruction[4]].zero?
  end

  def register?(value)
    registers.keys.include?(value)
  end

  def format_instructions(instructions)
    instructions.split("\n")
  end

  def create_registers
    registers = {}

    instructions.each do |instruction|
      next unless letter?(instruction[4])
      registers[instruction[4]] = 0
    end

    registers
  end

  def letter?(value)
    value.to_i.zero?
  end
end
