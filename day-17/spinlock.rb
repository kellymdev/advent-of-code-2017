class Spinlock
  attr_reader :step_count
  attr_accessor :buffer, :current_position

  def initialize(step_count)
    @step_count = step_count
    @buffer = [0]
    @current_position = 0
  end

  def create_circular_buffer
    2017.times do |current_value|
      cycle_circular_buffer(current_value)
    end
  end

  def create_fast_circular_buffer
    50_000_000.times do |current_value|
      print_value(current_value)
      cycle_circular_buffer(current_value)
    end
  end

  def print_value_after(num)
    index_of_num = buffer.index(num)
    print_value(buffer[index_of_num + 1])
  end

  private

  def print_value(value)
    puts "Value is: #{value}"
  end

  def cycle_circular_buffer(current_value)
    increment_current_position
    @buffer.insert(current_position, current_value + 1)
  end

  def increment_current_position
    @current_position += step_count

    if @current_position > buffer.size - 1
      @current_position = (@current_position % buffer.size) + 1
    else
      @current_position += 1
    end
  end
end
