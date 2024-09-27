require 'pry'
require_relative 'script'
require_relative 'player'
require_relative 'computer'

# Controller for the game
class Controller
  COLORS = %w[R O Y G B P]
  attr_accessor :guess

  def initialize
    @guess = []
    @code = []
    @hint = []
    @turns = 1
    @max_turns = 12
    @game_mode = 0
    @player = Player.new
    @computer = Computer.new
    @script = Script.new
  end

  def play
    @script.instructions
    @player.set_name
    loop do
      game_setup
      break unless @script.play_again?
    end
  end

  # Starting the game
  def game_setup
    game_mode
    if @mode == 1
      codebreaker
    elsif @mode == 2
      codemaker
    end
  end

  # Asks user if they want to make the code or break the code
  def game_mode
    valid = false
    until valid
      @mode = @script.welcome

      if @mode.positive? && @mode <= 2
        valid = true
      else
        system 'clear'
        @script.invalid_game_mode
      end
    end
  end

  def codebreaker
    system 'clear'
    @code = @computer.generate_code

    until @turns > @max_turns
      @script.guess_script
      @guess = @player.make_guess
      get_results
      puts "\nGuess number: #{@turns}"
      show_result

      if win?
        @script.player_win
        return
      end
      @turns += 1
    end
    @script.player_lose
  end

  def codemaker
    @script.color_choices
    @code = @player.make_code

    while @turns <= @max_turns
      # @computer.debug
      @computer.make_guess
      @guess = @turns == 1 ? @computer.initial_guess : @computer.final_array
      @computer.temp.clear if @turns > 1

      puts "\nGuess number: #{@turns}"
      get_results
      @script.computer_thinking
      show_result
      @computer.logic(@hint, @guess)
      @computer.any_nil?

      if win?
        @script.computer_win
        return
      end
      @turns += 1
    end
    @script.player_win
  end

  def get_results
    @hint = Array.new(@guess.length)
    @guess.each_with_index do |color, i|
      @hint[i] = if color == @code[i]
                   'Exact'
                 elsif @code.include?(color)
                   'Near'
                 else
                   'Nope'
                 end
    end
    @hint
  end

  def show_result
    puts "\n"
    puts "\t   Choice 1 \t Choice 2\t Choice 3\t Choice 4"
    puts '-' * 70
    puts "Guess  |\t#{@guess.join("\t\t")}"
    puts "Result |\t#{@hint.join("\t\t")}"
    puts "\n"
  end

  def win?
    @hint.all? { |a| a == 'Exact' }
  end
end
