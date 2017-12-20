require_relative 'disk_defragmenter'

input = 'flqrgnkx' #test input
# input = 'oundnydw' #puzzle input

# Part 1
defragmenter = DiskDefragmenter.new(input)
usage = defragmenter.calculate_disk_usage
defragmenter.print_disk_usage(usage)

# Part 2
regions = defragmenter.find_regions
defragmenter.print_region_count(regions)
