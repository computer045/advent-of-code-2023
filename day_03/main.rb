def main
  # Example input
  # input = <<~INPUT
  #   467..114..
  #   ...*......
  #   ..35..633.
  #   ......#...
  #   617*......
  #   .....+.58.
  #   ..592.....
  #   ......755.
  #   ...$.*....
  #   .664.598..
  # INPUT
  # input = input.split("\n")

  input = File.read('./input.txt').split("\n")
  puts part_one(input)
  #puts part_two(input)
end

def part_one(input)
  part_numbers_pos = []
  symbols_pos = []
  input.each do |line|
    part_numbers_pos.push(line.enum_for(:scan, /\d+/).map { { pos_start: Regexp.last_match.begin(0), pos_end: Regexp.last_match.begin(0) + (Regexp.last_match[0].size - 1) } })
    symbols_pos.push(line.enum_for(:scan,/[^\d.]/).map { Regexp.last_match.begin(0) })
  end

  found_parts = []
  symbols_pos.each_with_index do |positions, y_pos|
    positions.each do |x_pos|
      temp_array = []
      check_pos = [
        { y_pos: y_pos, x_pos: x_pos - 1 },
        { y_pos: y_pos, x_pos: x_pos + 1 },
        { y_pos: y_pos - 1, x_pos: x_pos },
        { y_pos: y_pos + 1, x_pos: x_pos },
        { y_pos: y_pos - 1, x_pos: x_pos - 1 },
        { y_pos: y_pos - 1, x_pos: x_pos + 1 },
        { y_pos: y_pos + 1, x_pos: x_pos - 1 },
        { y_pos: y_pos + 1, x_pos: x_pos + 1 }
      ]
      check_pos.each do |c_pos|
        if c_pos[:y_pos] >= 0 &&
           c_pos[:x_pos] >= 0 &&
           c_pos[:y_pos] < input.size &&
           c_pos[:x_pos] < input[0].size &&
           input[c_pos[:y_pos]][c_pos[:x_pos]] != '.'
          part_numbers_pos[c_pos[:y_pos]].each do |pn_pos|
            if c_pos[:x_pos] >= pn_pos[:pos_start] && c_pos[:x_pos] <= pn_pos[:pos_end]
              temp_array.push(input[c_pos[:y_pos]].chars[pn_pos[:pos_start]..pn_pos[:pos_end]].join)
            end
          end
        end
      end
      found_parts.concat(temp_array.uniq)
    end
  end
  found_parts.map(&:to_i).sum
end

main
