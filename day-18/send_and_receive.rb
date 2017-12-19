class SendAndReceive
  attr_reader :program_0, :program_1

  def initialize(instructions)
    @program_0 = Program.new(0, instructions)
    @program_1 = Program.new(1, instructions)
  end

  def run_programs
    loop do
      program_0_value = program_0.run_program
      program_1_value = program_1.run_program

      break unless program_1_value
      program_0.receive_new_value(program_1_value)

      break unless program_0_value
      program_1.receive_new_value(program_0_value)
      program_1.print_sent_value_count
    end
  end
end
