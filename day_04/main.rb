def main
  # Example input
  # input = <<~INPUT
  #   Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
  #   Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
  #   Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
  #   Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
  #   Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
  #   Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
  # INPUT
  # input = input.split("\n")

  input = File.read('./input.txt').split("\n")
  cards = (input.map { |line| line.split(':').last }).map{ |h| Hash[ [:win_nums, :card_nums].zip(h.split('|')) ] }
  cards.each do |card|
    card[:win_nums] = card[:win_nums].strip.split(/\s+/).map(&:to_i)
    card[:card_nums] = card[:card_nums].strip.split(/\s+/).map(&:to_i)
  end
  puts part_one(cards)
  puts part_two(cards)
end

def part_one(cards)
  points = []
  cards.each do |card|
    points.push(card[:win_nums].size - (card[:win_nums] - card[:card_nums]).size)
  end
  points.map! { |p| p > 1 ? (2 ** p) / 2 : p }
  points.sum
end

def part_two(cards)
  card_instances = Array.new(cards.size, 1)
  cards.each_with_index do |card, card_index|
    win_count = card[:win_nums].size - (card[:win_nums] - card[:card_nums]).size
    for idx in 1..win_count do
      card_instances[(card_index + idx)] += card_instances[card_index]
    end
  end
  card_instances.sum
end

main
