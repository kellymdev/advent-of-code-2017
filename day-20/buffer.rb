class Buffer
  attr_accessor :particles

  ITERATIONS = 1000

  def initialize(particle_list)
    @particles = format_particle_list(particle_list)
  end

  def move_particles
    ITERATIONS.times do
      update_particles
    end

    particles.each do |particle, particle_data|
      calculate_manhattan_distance(particle, particle_data[:position])
    end

    distance = find_closest_distance
    closest_particle = find_particles_with_closest_distance(distance)
  end

  def move_particles_with_collisons
    ITERATIONS.times do
      update_particles
      remove_collisons
    end

    particles.each do |particle, particle_data|
      calculate_manhattan_distance(particle, particle_data[:position])
    end

    print_particle_count
  end

  def print_particle_count
    puts "There are #{particles.size} particles left"
  end

  def print_closest_particle(particle_list)
    puts "Closest particle is: #{particle_list.first}"
  end

  private

  def remove_collisons
    particles.each do |particle, particle_data|
      x = particle_data[:position][:x].last
      y = particle_data[:position][:y].last
      z = particle_data[:position][:z].last

      delete_collisons(particle, x, y, z)
    end
  end

  def delete_collisons(particle_number, x_value, y_value, z_value)
    particles.each do |particle, particle_data|
      next if particle == particle_number
      next unless particle_data[:position][:x].last == x_value && particle_data[:position][:y].last == y_value && particle_data[:position][:z].last == z_value

      @particles.delete(particle)
      @particles.delete(particle_number)
    end
  end

  def find_particles_with_closest_distance(closest_distance)
    particles.map do |particle, particle_data|
      next unless particle_data[:distance] == closest_distance
      particle
    end.compact
  end

  def find_closest_distance
    distance = particles.map do |particle, particle_data|
      particle_data[:distance]
    end.min
  end

  def calculate_manhattan_distance(particle, position_data)
    distance = 0

    position_data[:x].each.with_index do |x_value, index|
      distance += x_value.abs + (position_data[:y][index]).abs + (position_data[:z][index]).abs
    end

    @particles[particle][:distance] = distance
  end

  def update_particles
    particles.each do |particle, _|
      update_particle_velocity(particle)
      update_particle_position(particle)
    end
  end

  def update_particle_velocity(particle)
    update_velocity(particle, :x)
    update_velocity(particle, :y)
    update_velocity(particle, :z)
  end

  def update_particle_position(particle)
    update_position(particle, :x)
    update_position(particle, :y)
    update_position(particle, :z)
  end

  def update_velocity(particle, coordinate)
    @particles[particle][:velocity][coordinate] += @particles[particle][:acceleration][coordinate]
  end

  def update_position(particle, coordinate)
    @particles[particle][:position][coordinate] << (@particles[particle][:position][coordinate].last + @particles[particle][:velocity][coordinate])
  end

  def format_particle_list(particle_list)
    particles = {}
    list = particle_list.split("\n")
    list.each.with_index do |particle, index|
      particles[index] = format_particle(particle)
    end

    particles
  end

  def format_particle(particle)
    values = particle.split(', ')
    position = format_particle_data(values[0])
    velocity = format_particle_data(values[1])
    acceleration = format_particle_data(values[2])

    {
      position: format_position_data(position),
      velocity: velocity,
      acceleration: acceleration
    }
  end

  def format_position_data(position_data)
    position_data.each do |coordinate, value|
      position_data[coordinate] = [value]
    end
  end

  def format_particle_data(particle_data)
    x, y, z = particle_data[3..-2].split(',').map(&:to_i)

    {
      x: x,
      y: y,
      z: z
    }
  end
end
