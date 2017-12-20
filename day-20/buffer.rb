class Buffer
  attr_accessor :particles

  def initialize(particle_list)
    @particles = format_particle_list(particle_list)
  end

  def move_particles
    update_particles
  end

  private

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
    @particles[particle][:position][coordinate] += @particles[particle][:velocity][coordinate]
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
      position: position,
      velocity: velocity,
      acceleration: acceleration
    }
  end

  def format_particle_data(particle_data)
    x, y, z = particle_data[4..-2].split(',').map(&:to_i)

    {
      x: x,
      y: y,
      z: z
    }
  end
end
