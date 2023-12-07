def main
  # Example input
  input = <<~INPUT
    Time:      7  15   30
    Distance:  9  40  200
  INPUT
  input = input.split("\n")
  input = File.read('./input.txt').split("\n")

  puts part_one(input)
  puts part_two(input)
end

def part_one(input)
  0
end

def part_two(input)
  0
end

main
