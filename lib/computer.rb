# frozen_string_literal: true

require_relative 'controller'
# Computer class

class Computer # rubocop:todo Style/Documentation
  attr_accessor :final_array, :temp, :possible_colors

  def initialize
    @temp = Array.new(4)
    @initial_guess = []
    @free_indexes = []
    @final_array = []
    @possible_colors = Controller::COLORS.dup
  end

  def generate_code
    @possible_colors.sample(4)
  end

  def initial_guess
    @initial_guess = @possible_colors.sample(4).uniq
    while @initial_guess.size < 4
      new_color = @possible_colors.sample
      @initial_guess << new_color unless @initial_guess.include?(new_color)
    end
    @initial_guess
  end

  def make_guess
    @temp = Array.new(4)
  end

  def logic(hint, guess)
    hint.each_with_index do |status, i|
      # puts "Current guess: #{guess[i]}, Status: #{status}, Possible Colors: #{@possible_colors.inspect}"

      case status
      when 'Exact'
        @temp[i] = guess[i]
        @possible_colors.delete(guess[i])
        # puts "Keeping color #{guess[i]} at index #{i}"
      when 'Near'

        if @new_index
          chosen_color = choose_random_color(guess[i])
          # puts "Assigning Near color: #{chosen_color} to index #{@new_index}"
          @temp[@new_index] = chosen_color
        end
      when 'Nope'

        @possible_colors.delete(guess[i])
        if @new_index
          assigned_color = @possible_colors.sample
          # puts "Assigning Nope color: #{assigned_color} to index #{@new_index}"
          @temp[@new_index] = assigned_color if assigned_color
          # puts "Assigning Nope color: #{assigned_color} to index #{@new_index}"
        end
      end
      find_empty_indexes
    end
    @final_array = @temp
  end

  def any_nil?
    @temp.each_with_index do |value, i|
      @temp[i] = @possible_colors.sample if value.nil?
    end
    @final_array = @temp
  end

  def choose_random_color(color)
    raise 'No free indexes available!' if @free_indexes.empty?

    max_attempts = 5
    attempts = 0

    loop do
      # puts "Free indexes: #{@free_indexes.inspect}"
      new_color = @possible_colors.sample(@free_indexes.size).find { |c| c != color }
      return new_color if new_color

      attempts += 1
      return (@possible_colors - [color]).sample if attempts >= max_attempts
    end
  end

  def find_empty_indexes
    @free_indexes.clear
    @temp.each_with_index do |value, i|
      @free_indexes << i if value.nil?
    end
    @new_index = @free_indexes.sample
  end

  def debug
    puts "Temp: #{@temp.inspect}"
    puts "Possible colors: #{@possible_colors.inspect}}"
    puts "Guess: #{@guess.inspect}"
    puts "Free Indexes: #{@free_indexes.inspect}"
    puts "New index: #{@new_index}"
    puts "Final array #{@final_array.inspect}"
  end
end
