class ConnectPipes
  attr_reader :connections

  def initialize(connection_list)
    @connections = format_connections(connection_list)
  end

  def find_group_for(program)
    group = [program]
    links_to_check = find_links(program)

    until links_to_check.empty?
      link = links_to_check.shift
      group << link

      new_links = find_links(link)
      new_links.reject! { |new_link| group.include?(new_link) }

      links_to_check += new_links
    end

    group.uniq.size
  end

  def print_program_count(count)
    puts "#{count} programs in group"
  end

  private

  def find_links(program)
    connections[program]
  end

  def format_connections(connection_list)
    programs = {}
    connections = connection_list.split("\n")

    connections.each do |connection|
      program, link_list = connection.split(' <-> ')
      links = link_list.split(', ')
      programs[program] = links
    end

    programs
  end
end
