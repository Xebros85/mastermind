# frozen_string_literal: true

# Computer class

COLORS = %w[r b g y o p].freeze
CODE_LENGTH = 4

class Computer
  attr_reader :secret_code

  def initialize
    @secret_code = generate_code
  end

  def generate_code
    Array.new(CODE_LENGTH) { COLORS.sample }
  end

  def check_guess(guess)
    correct_positions = 0
    correct_colors = 0

    secret_copy = @secret_code.dup
    guess_copy = guess.dup

    guess.each_with_index do |color, index|
      next unless color == secret_copy[index]

      correct_positions += 1
      secret_copy[index] = nil
      guess_copy[index] = nil
    end

    guess_copy.each do |color|
      if color && secret_copy.include?(color)
        correct_colors += 1
        secret_copy[secret_copy.index(color)] = nil
      end
    end

    { correct_positions: correct_positions, correct_colors: correct_colors }
  end
end
