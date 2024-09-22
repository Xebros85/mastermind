# frozen_string_literal: true

require_relative 'controller'
require_relative 'script'

# Player Class

class Player # rubocop:todo Style/Documentation
  attr_accessor :name, :guess, :code

  def initialize
    @script = Script.new
    @name = nil
  end

  def set_name
    puts 'Please enter your name: '
    @name = gets.chomp.capitalize
    puts
    puts "Welcome #{@name}!"
  end

  def make_guess
    @guess = []
    while @guess.size < 4
      print "Color #{@guess.size + 1}: "
      color = gets.chomp.upcase
      Controller::COLORS.include?(color) ? @guess << color : @script.invalid_color
    end
    @guess
  end

  def make_code
    @code = []
    while @code.size < 4
      print "Color #{@code.size + 1}:"
      color = gets.chomp.upcase
      Controller::COLORS.include?(color) ? @code << color : @script.invalid_color
    end
    @code
  end
end
