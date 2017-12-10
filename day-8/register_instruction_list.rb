class RegisterInstructionList
  attr_reader :list
  attr_accessor :registers, :highest_value

  def initialize(list)
    @list = format_list(list)
    @highest_value = 0
  end

  def process_register_instructions
    create_registers

    list.each do |instruction|
      perform_instruction(instruction)
    end
  end

  def print_largest_register_value
    max_value = registers.values.max
    puts "The largest register value is: #{max_value}"
  end

  def print_highest_value
    puts "The highest value was: #{highest_value}"
  end

  private

  def perform_instruction(instruction)
    # b inc 5 if a > 1
    formatted = format_instruction(instruction)
    update_register(formatted) if execute_instruction?(formatted)
  end

  def update_register(formatted_instruction)
    case formatted_instruction[:direction]
    when 'inc'
      registers[formatted_instruction[:register]] += formatted_instruction[:value]
    when 'dec'
      registers[formatted_instruction[:register]] -= formatted_instruction[:value]
    end

    update_highest_value(registers[formatted_instruction[:register]])
  end

  def update_highest_value(register_value)
    return unless register_value > highest_value

    @highest_value = register_value
  end

  def execute_instruction?(formatted_instruction)
    register = registers[formatted_instruction[:condition_register]]
    value = formatted_instruction[:condition_value]

    case formatted_instruction[:sign]
    when '>'
      register > value
    when '<'
      register < value
    when '>='
      register >= value
    when '<='
      register <= value
    when '=='
      register == value
    when '!='
      register != value
    else
      false
    end
  end

  def format_instruction(instruction)
    move, condition = instruction.split(' if ')
    register, direction, value = move.split(' ')
    condition_register, sign, condition_value = condition.split(' ')

    {
      register: register,
      direction: direction,
      value: value.to_i,
      condition_register: condition_register,
      sign: sign,
      condition_value: condition_value.to_i
    }
  end

  def create_registers
    @registers = {}
    list.each do |instruction|
      name = instruction.split(' ').first
      @registers[name] = 0
    end
  end

  def format_list(list)
    list.split("\n")
  end
end
