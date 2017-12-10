class ProgramTowers
  attr_accessor :tower_list

  def initialize(tower_list)
    @tower_list = format_tower_list(tower_list)
  end

  def find_bottom_tower
    tower_list.each do |tower, _|
      next unless bottom_tower?(tower)
      return tower
    end
  end

  def find_unbalanced_tower
    bottom_tower = find_bottom_tower
    bottom_discs = tower_list[bottom_tower][:discs]

    bottom_discs.each do |disc_name|
      disc = tower_list[disc_name]
      weight = calculate_disc_weight(disc)
      disc[:total_weight] = weight
    end

    find_unbalanced_disc(bottom_discs)
  end

  def print_unbalanced_disc(disc)
    weight = tower_list[disc[:name]][:weight] + disc[:weight_difference]

    puts "The unbalanced disc is #{disc[:name]}. The difference is #{disc[:weight_difference]}. It's weight would need to be #{weight}"
  end

  def print_bottom_tower(tower)
    puts "The bottom tower is #{tower}"
  end

  private

  def calculate_disc_weight(disc)
    disc_list = disc[:discs]

    discs_weight = disc_list.map do |top_disc|
      tower_list[top_disc][:weight]
    end.reduce(:+)

    disc[:weight] + discs_weight
  end

  def find_unbalanced_disc(bottom_discs)
    frequencies = find_weight_frequencies(bottom_discs)
    unbalanced_weight = frequencies.key(1)
    unbalanced_disc = tower_list.select do |_, details|
      details[:total_weight] == unbalanced_weight
    end
    difference = (frequencies.keys.uniq - [unbalanced_weight]).join.to_i - unbalanced_weight

    {
      name: unbalanced_disc.keys.first,
      weight_difference: difference
    }
  end

  def find_weight_frequencies(bottom_discs)
    frequencies = {}
    bottom_discs.each do |disc_name|
      weight = tower_list[disc_name][:total_weight]
      frequencies.key?(weight) ? frequencies[weight] += 1 : frequencies[weight] = 1
    end

    frequencies
  end

  def bottom_tower?(tower)
    tower_list.each do |disc, details|
      next if disc == tower
      next unless details[:discs]
      return false if details[:discs].include?(tower)
    end

    true
  end

  def format_tower(tower)
    name_and_weight, disc_list = tower.split(' -> ')
    name, weight = name_and_weight.split(' ')
    discs = disc_list.split(', ') if disc_list
    formatted_weight = format_weight(weight)
    {
      name => {
        weight: formatted_weight,
        discs: discs
      }
    }
  end

  def format_weight(weight)
    weight.gsub!(/\(/, '')
    weight.gsub!(/\)/, '')
    weight.to_i
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
