require_relative 'disk_defragmenter'

input = 'flqrgnkx'

# Part 1
defragmenter = DiskDefragmenter.new(input)
usage = defragmenter.calculate_disk_usage
defragmenter.print_disk_usage(usage)
