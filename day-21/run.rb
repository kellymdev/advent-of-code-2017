require_relative 'fractal_art'

input = <<EOF
../.# => ##./#../...
.#./..#/### => #..#/..../..../#..#
EOF

# Part 1
art = FractalArt.new(input)
art.generate_art
