# Game class and main gameplay
require_relative 'lib/computer.rb'
require_relative 'lib/gameboard.rb'
require_relative 'lib/player.rb'


player = Player.new
computer = Computer.new
board = Gameboard.new

player.hello
computer.hello
board.hello