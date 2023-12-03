def main
  # Example input
  # input = <<~INPUT
  #   Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
  #   Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
  #   Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
  #   Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
  #   Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
  # INPUT
  # input = input.split("\n")

  input = File.read('./input.txt').split("\n")
  games = []
  input.each do |line|
    games.push(((line.split(':').last).split(';')).map { |s| s.split(',').map(&:strip).map{ |h| Hash[ [:number, :color].zip(h.split(/\s+/,2)) ] } })
  end
  puts part_one(games, 12, 13, 14)
  puts part_two(games)
end

def part_one(games, max_red, max_green, max_blue)
  id_sum = 0
  games.each_with_index do |game_sets, idx|
    valid = true
    game_sets.each do |set|
      set.each do |hand|
        valid =
          case hand[:color]
          when 'red' then
            hand[:number].to_i <= max_red
          when 'green' then
            hand[:number].to_i <= max_green
          when 'blue' then
            hand[:number].to_i <= max_blue
          end
        break if !valid
      end
      break if !valid
    end
    id_sum += (idx + 1) if valid
  end
  id_sum
end

def part_two(games)
  power_sum = 0
  games.each do |game_sets|
    min_red = -1
    min_green = -1
    min_blue = -1
    game_sets.each do |set|
      set.each do |hand|
        case hand[:color]
        when 'red' then
          min_red = hand[:number].to_i if min_red == -1 || hand[:number].to_i > min_red
        when 'green' then
          min_green = hand[:number].to_i if min_green == -1 || hand[:number].to_i > min_green
        when 'blue' then
          min_blue = hand[:number].to_i if min_blue == -1 || hand[:number].to_i > min_blue
        end
      end
    end
    power_sum += (min_red * min_green * min_blue).abs
  end
  power_sum
end

main
