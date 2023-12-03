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
  puts part_one(input, 12, 13, 14)
  #puts part_two(input)
end

def part_one(input, max_red, max_green, max_blue)
  id_sum = 0
  input.each_with_index do |line, idx|
    # puts "Game #{(idx + 1).to_s}"
    game_sets = ((line.split(':').last).split(';')).map { |s| s.split(',').map(&:strip).map{ |h| Hash[ [:number, :color].zip(h.split(/\s+/,2)) ] } }
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

main
