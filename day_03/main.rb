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
    symbols_pos.push(line.enum_for(:scan,/[\*\#\+\-\=\&\$\@\%\/]/).map { Regexp.last_match.begin(0) })
  end

  found_parts = []
  symbols_pos.each_with_index do |positions, y_pos|
    temp_array = []
    positions.each do |x_pos|
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
      # puts "#{x_pos} #{y_pos} #{input[0].size}"
      puts "char: #{input[y_pos].chars[x_pos]}"
      check_pos.each do |c_pos|
        if c_pos[:y_pos] >= 0 &&
           c_pos[:x_pos] >= 0 &&
           c_pos[:y_pos] < input.size &&
           c_pos[:x_pos] < input[0].size &&
           input[c_pos[:y_pos]][c_pos[:x_pos]] != '.'
          puts c_pos
          part_numbers_pos[c_pos[:y_pos]].each do |pn_pos|
            found_num = false
            if c_pos[:x_pos] >= pn_pos[:pos_start] && c_pos[:x_pos] <= pn_pos[:pos_end]
              #puts input[c_pos[:y_pos]].chars[pn_pos[:pos_start]..pn_pos[:pos_end]].join
              found_num = true
              temp_array.push(input[c_pos[:y_pos]].chars[pn_pos[:pos_start]..pn_pos[:pos_end]].join)
            end
            break if found_num
          end
        end
      end
    end
    puts temp_array.uniq
    found_parts.concat(temp_array.uniq)
  end
  # puts found_parts
  found_parts.map(&:to_i).sum
end

main
