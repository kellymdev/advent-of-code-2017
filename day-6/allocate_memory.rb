class AllocateMemory
  attr_accessor :memory_bank, :configurations, :cycles

  def initialize(input)
    @memory_bank = format_memory_bank(input)
    @configurations = []
    @cycles = 0
  end

  def distribute_memory
    while configurations.none? { |configuration| configuration == memory_bank.join(' ') }
      configurations << memory_bank.join(' ')
      highest = find_highest_memory_bank
      allocate_memory(highest)
      increment_cycles
    end
  end

  def print_cycles
    puts "Memory looped after #{cycles} cycles"
  end

  private

  def allocate_memory(highest)
    @memory_bank[highest[:index]] = 0
    memory = highest[:value]
    current_index = highest[:index]

    while memory > 0
      current_index == 15 ? current_index = 0 : current_index += 1
      @memory_bank[current_index] += 1
      memory -= 1
    end
  end

  def find_highest_memory_bank
    value = memory_bank.max
    index = memory_bank.index(value)

    { value: value, index: index }
  end

  def format_memory_bank(input)
    input.split(' ').map(&:to_i)
  end

  def increment_cycles
    @cycles += 1
  end
end
