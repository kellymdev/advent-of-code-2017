require_relative 'firewall'

# input = <<EOF
# 0: 4
# 1: 2
# 2: 3
# 4: 4
# 6: 6
# 8: 5
# 10: 6
# 12: 6
# 14: 6
# 16: 12
# 18: 8
# 20: 9
# 22: 8
# 24: 8
# 26: 8
# 28: 8
# 30: 12
# 32: 10
# 34: 8
# 36: 12
# 38: 10
# 40: 12
# 42: 12
# 44: 12
# 46: 12
# 48: 12
# 50: 14
# 52: 14
# 54: 12
# 56: 12
# 58: 14
# 60: 14
# 62: 14
# 66: 14
# 68: 14
# 70: 14
# 72: 14
# 74: 14
# 78: 18
# 80: 14
# 82: 14
# 88: 18
# 92: 17
# EOF

input = <<EOF
0: 3
1: 2
4: 4
6: 4
EOF

# Part 1
firewall = Firewall.new(input)
severity = firewall.calculate_severity_of_trip
firewall.print_severity(severity)

# Part 2
safe_trip = Firewall.new(input)
seconds_to_delay = firewall.find_safe_path
firewall.print_delay(seconds_to_delay)
