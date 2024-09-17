# Game class and main gameplay
require_relative 'lib/computer.rb'
require_relative 'lib/gameboard.rb'
require_relative 'lib/player.rb'

# What do I want the board to look like?
# [o, o ,o, o] ?? How to display?

# update board function

# Instead of o use the first letter of the color?

# [o, o ,o, o]
# [o, o ,o, o]
# [o, o ,o, o]
# [o, o ,o, o]
# [o, o ,o, o]
# [o, o ,o, o]
# [o, o ,o, o]
# [o, o ,o, o]
# [o, o ,o, o]
# [o, o ,o, o]

# White is incorrect if not in array
# Orange is in array but not in the right spot
# Green when in array AND in correct position


player = Player.new
computer = Computer.new
board = Gameboard.new

player.hello
computer.hello
board.hello
