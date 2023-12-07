def main
  # Example input
  input = <<~INPUT
    Time:      7  15   30
    Distance:  9  40  200
  INPUT
  input = File.read('./input.txt')
  input1 = Hash[
    [:time, :distance].zip(
      input.split("\n").map{
        |line| line.split(':').last.strip.split(/\s+/).map(&:to_i)
      }
    )
  ]
  input2 = Hash[
    [:time, :distance].zip(
      input.split("\n").map{
        |line| [line.split(':').last.gsub(/\s/, '').to_i]
      }
    )
  ]
  puts part_one(input1)
  puts part_two(input2)
end

def part_one(input)
  distances = []
  input[:time].each do |time|
    race_distances = []
    (0..time).each do |m_sec|
      race_distances.push(m_sec * (time - m_sec))
    end
    distances.push(race_distances)
  end
  win_values = distances.each_with_index.map { |race, idx| race.select { |dist| dist > input[:distance][idx] }.size }
  win_values.inject(:*)
end

def part_two(input)
  part_one(input)
end

main
