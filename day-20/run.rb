require_relative 'buffer'

input = <<EOF
p=< 3,0,0>, v=< 2,0,0>, a=<-1,0,0>
p=< 4,0,0>, v=< 0,0,0>, a=<-2,0,0>
EOF

# Part 1
buffer = Buffer.new(input)
buffer.move_particles
