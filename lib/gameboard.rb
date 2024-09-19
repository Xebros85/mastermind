
class GameBoard
  attr_accessor :guesses

  def initialize
    @guesses = []
  end

  def record_guess(guess, result)
    @guesses << { guess: guess, result: result }
  end

  def display_board
    puts "\nCurrent Guesses:"
    @guesses.each do |entry|
      puts "Guess: #{entry[:guess].join(', ')} -> Correct positions #{entry[:result][:correct_positions]}, Correct Colors: #{entry[:result][:correct_colors]}"
    end
  end
    
end