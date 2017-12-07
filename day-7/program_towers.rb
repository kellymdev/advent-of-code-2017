class ProgramTowers
  attr_reader :tower_list

  def initialize(tower_list)
    @tower_list = format_tower_list(tower_list)
  end

  def find_bottom_tower
    tower_list.each do |tower, _|
      next unless bottom_tower?(tower)
      print_bottom_tower(tower)
    end
  end

  private

  def bottom_tower?(tower)
    tower_list.each do |disc, details|
      next if disc == tower
      next unless details[:discs]
      return false if details[:discs].include?(tower)
    end

    true
  end

  def print_bottom_tower(tower)
    puts "The bottom tower is #{tower}"
  end

  def format_tower(tower)
    name_and_weight, disc_list = tower.split(' -> ')
    name, weight = name_and_weight.split(' ')
    discs = disc_list.split(', ') if disc_list
    {
      name => {
        weight: weight,
        discs: discs
      }
    }
  end

  def format_tower_list(tower_list)
    list = {}
    towers = tower_list.split("\n")
    towers.each do |tower|
      list.merge!(format_tower(tower))
    end

    list
  end
end
