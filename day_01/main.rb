
def main
  # Part one example input
  #input = <<~INPUT
  #  1abc2
  #  pqr3stu8vwx
  #  a1b2c3d4e5f
  #  treb7uchet
  #INPUT

  # Part two example input
  # input = <<~INPUT
  #   two1nine
  #   eightwothree
  #   abcone2threexyz
  #   xtwone3four
  #   4nineeightseven2
  #   zoneight234
  #   7pqrstsixteen
  # INPUT
  # input = input.split("\n")

  input = File.read('./input.txt').split("\n")
  puts part_one(input)
  puts part_two(input)
end

def part_one(input)
  cal_value_sum = 0
  input.each do |line|
    values = line.chars.grep(/\d/)
    cal_value = "#{values.first}#{values.last}".to_i
    cal_value_sum += cal_value
  end
  cal_value_sum
end

def part_two(input)
  words_hash = {
    "one" =>    1,
    "two" =>    2,
    "three" =>  3,
    "four" =>   4,
    "five" =>   5,
    "six" =>    6,
    "seven" =>  7,
    "eight" =>  8,
    "nine" =>   9
  }
  new_input = []

  input.each do |line|
    matches = []
    words_hash.each do |word, value|
      word_index = line.enum_for(:scan, /(?=#{word})/).map { Regexp.last_match.offset(0).first }
      if !word_index.empty?
        matches.push({word_index: word_index, word: word, value: value})
      end
    end
    matches = matches.sort_by { |m| m[:word_index] }
    ipos = 0;
    matches.each_with_index do |m|
      m[:word_index].each_with_index do |wi, idx|
        line = line.insert(wi + idx + ipos, m[:value].to_s)
      end
      ipos += m[:word_index].size
    end
    new_input.push(line)
  end
  part_one(new_input)
end

main
