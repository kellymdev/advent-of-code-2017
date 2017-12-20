class Buffer
  attr_accessor :particle_list

  def initialize(particle_list)
    @particles = format_particle_list(particle_list)
  end

  private

  def format_particle_list(particle_list)
    list = particle_list.split("\n")
    list.each do |particle|
      particle.split(', ')
    end
  end
end
