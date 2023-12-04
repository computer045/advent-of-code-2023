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
  puts part_two(input)
end

def part_one(input)
  part_numbers_pos = []
  symbols_pos = []
  input.each do |line|
    part_numbers_pos.push(line.enum_for(:scan, /\d+/).map { { pos_start: Regexp.last_match.begin(0), pos_end: Regexp.last_match.begin(0) + (Regexp.last_match[0].size - 1) } })
    symbols_pos.push(line.enum_for(:scan,/[^\d.]/).map { Regexp.last_match.begin(0) })
  end
  pn_list = []
  find_part_numbers(input, symbols_pos, part_numbers_pos).each do |pn|
    pn_list.concat(pn[:part_nums])
  end
  pn_list.sum
end

def part_two(input)
  part_numbers_pos = []
  symbols_pos = []
  input.each do |line|
    part_numbers_pos.push(line.enum_for(:scan, /\d+/).map { { pos_start: Regexp.last_match.begin(0), pos_end: Regexp.last_match.begin(0) + (Regexp.last_match[0].size - 1) } })
    symbols_pos.push(line.enum_for(:scan,/[\*]/).map { Regexp.last_match.begin(0) })
  end
  gear_ratio_sum = 0
  find_part_numbers(input, symbols_pos, part_numbers_pos).each do |pn|
    if pn[:part_nums].size == 2
      gear_ratio_sum += pn[:part_nums].inject(:*)
    end
  end
  gear_ratio_sum
end

def find_part_numbers(input, symbols_pos, part_numbers_pos)
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
      found_parts.push({char: input[y_pos].chars[x_pos], part_nums: temp_array.uniq.map(&:to_i) })
    end
  end
  found_parts
end

main
