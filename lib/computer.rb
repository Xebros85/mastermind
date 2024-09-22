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
      case status
      when 'Exact'
        @temp[i] = guess[i]
        @possible_colors.delete(guess[i]) if @possible_colors.include?(guess[i])
      when 'Near'
        find_empty_indexes
        @temp[@new_index] = choose_random_color(guess[i]) if @new_index
      when 'Nope'
        @possible_colors.delete(guess[i])
        find_empty_indexes
        @temp[@new_index] = @possible_colors.sample if @new_index
      end
    end
    @final_array = @temp.dup
  end

  def any_nil?
    @temp.each_with_index do |value, i|
      @temp[i] = @possible_colors.sample if value.nil?
    end
    @final_array = @temp.dup
  end

  def choose_random_color(color)
    if @free_indexes.empty?
      puts 'Warning: No free indexes available!'
      raise 'No free indexes available to choose a random color.'
    end

    loop do
      puts "Free indexes: #{@free_indexes.inspect}"
      new_color = @possible_colors[@free_indexes.sample]
      return new_color unless new_color == color
    end
    # loop do
    #   new_color = @possible_colors[@free_indexes.sample]
    #   return new_color unless new_color == color
    # end
  end

  def find_empty_indexes
    @free_indexes.clear
    @temp.each_with_index do |value, i|
      @free_indexes << i if value.nil?
    end
    @new_index = @free_indexes.sample unless @free_indexes.empty?
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
