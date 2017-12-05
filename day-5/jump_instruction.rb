class JumpInstruction
  attr_accessor :instructions, :steps, :current_location

  def initialize(instructions)
    @instructions = format_instructions(instructions)
    @current_location = 0
    @steps = 0
  end

  def calculate_jumps
    while current_location < instructions.length
      instruction = instructions[current_location]
      perform_jump(instruction)
    end
  end

  def calculate_stranger_jumps
    while current_location < instructions.length
      instruction = instructions[current_location]
      perform_jump(instruction, strange_jump: true)
    end
  end

  def print_steps
    puts "Completed in #{steps} steps"
  end

  private

  def perform_jump(instruction, strange_jump: false)
    if strange_jump && instruction >= 3
      @instructions[current_location] -= 1
    else
      @instructions[current_location] += 1
    end

    @current_location += instruction
    increment_steps
  end

  def increment_steps
    @steps += 1
  end

  def format_instructions(instructions)
    instructions.split("\n").map(&:to_i)
  end
end
