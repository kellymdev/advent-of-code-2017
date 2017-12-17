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
      increment_current_position
      @buffer.insert(current_position, current_value + 1)
    end
  end

  def print_value_after_2017
    index_of_2017 = buffer.index(2017)
    puts "Value is: #{buffer[index_of_2017 + 1]}"
  end

  private

  def increment_current_position
    @current_position += step_count

    if @current_position > buffer.size - 1
      @current_position = (@current_position % buffer.size) + 1
    else
      @current_position += 1
    end
  end
end
