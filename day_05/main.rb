def main
  # Example input
  input = <<~INPUT
    seeds: 79 14 55 13

    seed-to-soil map:
    50 98 2
    52 50 48

    soil-to-fertilizer map:
    0 15 37
    37 52 2
    39 0 15

    fertilizer-to-water map:
    49 53 8
    0 11 42
    42 0 7
    57 7 4

    water-to-light map:
    88 18 7
    18 25 70

    light-to-temperature map:
    45 77 23
    81 45 19
    68 64 13

    temperature-to-humidity map:
    0 69 1
    1 0 69

    humidity-to-location map:
    60 56 37
    56 93 4
  INPUT
  input = input.split("\n\n")
  input = File.read('./input.txt').split("\n\n")

  maps = input.map { |block| block.split(':').last.strip }
  seeds = maps.shift.split(/\s+/).map(&:to_i)
  maps = maps.map {
    |block| block.split("\n").map {
      |h| Hash[ [:dest_start, :src_start, :range].zip(h.split(/\s+/).map(&:to_i)) ]
      }
    }
  puts part_one(seeds, maps)
  puts part_two(seeds, maps)
  # puts "test"
  # puts part_two_new(seeds, maps)
end

def part_one(seeds, maps)
  locations = []
  seeds.each do |seed|
    locations.push(find_next_node(seed, maps, 0))
  end
  locations.min
end

def find_next_node(src_node, maps, m_id)
  next_node = -1
  if m_id < maps.size
    map = maps[m_id]
    found = false
    map.each do |line|
      max_src = line[:src_start] + line[:range]
      max_dest = line[:dest_start] + line[:range]
      if src_node >= line[:src_start] && src_node < max_src
        found = true
        next_node = src_node + (line[:dest_start] - line[:src_start])
      end
    end
    next_node = src_node if !found
  end
  rtn_node = src_node
  rtn_node = find_next_node(next_node, maps, (m_id + 1)) if next_node > -1
  rtn_node
end

def part_two(seeds, maps)
  threads = []
  min_location = -1
  seeds.each_slice(2) do |seed_start, seed_range|
    # puts "start: #{seed_start} range: #{seed_range}"
    threads.push(Thread.new {
      (seed_start..(seed_start + seed_range)).each do |seed|
        location = find_next_node(seed, maps, 0)
        min_location = location if location < min_location || min_location == -1
      end
    })
  end
  threads.each(&:join)
  min_location
end

main
