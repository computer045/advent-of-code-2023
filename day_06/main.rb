def main
  # Example input
  input = <<~INPUT
    Time:      7  15   30
    Distance:  9  40  200
  INPUT
  # input = File.read('./input.txt')
  input = Hash[
    [:time, :distance].zip(
      input.split("\n").map{
        |line| line.split(':').last.strip.split(/\s+/).map(&:to_i)
      }
    )
  ]
  p input
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
