# frozen_string_literal: true

# Player Class

class Player
  def make_guess
    loop do
      puts "Enter your guess (#{CODE_LENGTH} colors from #{COLORS.join(', ')}):"
      input = gets.chomp.downcase.split

      return input if valid_guess?(input)

      puts "Invalid guess. Please enter exactly #{CODE_LENGTH} valid colors."
    end
  end

  private

  def valid_guess?(guess)
    guess.length == CODE_LENGTH && guess.all? { |color| COLORS.include?(color) }
  end
end
