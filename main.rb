# frozen_string_literal: true

# Game class and main gameplay
require_relative 'lib/computer'
require_relative 'lib/gameboard'
require_relative 'lib/player'

class Game # rubocop:todo Style/Documentation
  def initialize
    @player = Player.new
    @computer = Computer.new
    @game_board = GameBoard.new
    @turns = 0
    @max_turns = 12
    @secret_code = @computer.generate_code
  end

  def play # rubocop:todo Metrics/MethodLength
    until game_over?
      @game_board.display_board
      guess = @player.make_guess
      result = @computer.check_guess(guess)
      @game_board.record_guess(guess, result)
      @turns += 1
      if result[:correct_positions] == Computer::CODE_LENGTH
        puts "You've cracked the code!!"
        break
      end
    end
  end

  private

  def game_over?
    @turns >= @max_turns ||
      (@game_board.guesses.last && @game_board.guesses.last[:result][:correct_positions] == Computer::CODE_LENGTH)
  end
end

Game.new.play
